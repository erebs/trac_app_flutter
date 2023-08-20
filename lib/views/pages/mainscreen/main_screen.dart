import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac_app/contants/app_colors.dart';
import 'package:trac_app/contants/app_images.dart';
import 'package:trac_app/controllers/pay_controller.dart';
import 'package:trac_app/views/pages/mainscreen/navbaritems/frauds_screen.dart';
import 'package:trac_app/views/pages/mainscreen/navbaritems/home_screen.dart';
import 'package:trac_app/views/pages/mainscreen/navbaritems/notifications_screen.dart';
import 'package:trac_app/views/pages/mainscreen/navbaritems/profile_screen.dart';
import 'package:get/get.dart';
import 'package:trac_app/views/widgets/buttons.dart';
import 'package:upi_payment_flutter/upi_payment_flutter.dart';
import '../../../controllers/subscription_check_controller.dart';
import '../../../utils/snackbar.dart';
import '../loginscreen/login_screen.dart';


class MainScreen extends StatefulWidget {
  MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver{

  PageController pageController = PageController();
  final SubscriptionCheckController subscriptionCheckController = Get.put(SubscriptionCheckController());
  final PayController payController = Get.put(PayController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    getUserData();

  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      getUserData();
      onItemTapped(selectedIndex);
    }
  }

  String userName = "", userMemberId= "", shopId = "", userId = "";
  int selectedIndex = 0;
  bool isPresident = false;

  @override
  Widget build(BuildContext context) {



    return Stack(
      children: [

        Scaffold(
          backgroundColor: Colors.white,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: selectedIndex,
              selectedItemColor: AppColors.primary,
              selectedFontSize: 10,
              unselectedItemColor: Colors.grey,
              unselectedFontSize: 10,
              showSelectedLabels: false,
              onTap: onItemTapped,
              showUnselectedLabels: false,
              items: const [

                BottomNavigationBarItem(
                  icon: Icon( Remix.home_line,color: Colors.grey,),
                  label: 'home',
                  activeIcon: Icon( Remix.home_fill,color: AppColors.primary,),
                ),

                BottomNavigationBarItem(
                  icon: Icon( Remix.footprint_line,color: Colors.grey,),
                  label: 'frauds',
                  activeIcon: Icon( Remix.footprint_fill,color: AppColors.primary,),
                ),

                BottomNavigationBarItem(
                  icon: Icon( Remix.notification_3_line,color: Colors.grey,),
                  label: "notifications",
                  activeIcon: Icon( Remix.notification_3_fill,color: AppColors.primary,),
                ),

                BottomNavigationBarItem(
                  icon: Icon( Remix.user_3_line,color: Colors.grey,),
                  label: 'profile',
                  activeIcon: Icon( Remix.user_3_fill,color: AppColors.primary,),
                ),

              ],
            ),
          body: SizedBox.expand(
            child: PageView(
              controller: pageController,
              onPageChanged: (index) {
                setState(() => selectedIndex = index);
              },
              children: <Widget>[
                HomeScreen(),
                FraudsScreen(),
                NotificationsScreen(),
                ProfileScreen(userMemberId: userMemberId, userName: userName,userId: userId, shopId: shopId, isPresident: isPresident),
              ],
            ),
          ),
        ),

        Obx(() => subscriptionCheckController.isLoading.value?const SizedBox():
        SubscriptionCheckOverlay(
          message: subscriptionCheckController.subscriptionCheckModel.message??"",
          isActive: subscriptionCheckController.subscriptionCheckModel.status??false,
          onTap: () { payController.fetchData(shopId); },
          text: payController.isLoading.value?"Please wait...":"Get Subscription", )
        )

      ],
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  getUserData () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('user_name')!;
    userMemberId = prefs.getString('user_member_id')!;
    shopId = prefs.getInt('shop_id')!.toString();
    userId = prefs.getInt('user_id')!.toString();
    isPresident = prefs.getBool('is_president')??false!;
    subscriptionCheckController.fetchData(shopId);
  }

}

class SubscriptionCheckOverlay extends StatelessWidget {
  SubscriptionCheckOverlay({
    super.key,
    required this.text,
    required this.message,
    required this.onTap,
    required this.isActive,
  });
  final String message, text;
  final bool isActive;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return isActive?const SizedBox():Blur(
    blur: 1.6,
    blurColor: AppColors.fontOnWhite,
    overlay: Scaffold(
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 225,
          decoration: BoxDecoration(
              color: AppColors.fontOnSecondary,
              border: Border.all(width: 0, color: Colors.grey
                  .shade400),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20))
          ),
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(AppImages.warningAnimation, height: 50, width: 50,),
              const SizedBox(height: 10),
              Text(message,
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Flexible(
                    child: PrimaryButton(
                      bgColor: Colors.red,
                      buttonText: "Logout", onTap: () {
                      logout();
                    },),
                  ),

        SizedBox(width:10),

        Flexible(
          child: PrimaryButton(
            buttonText: text, onTap: onTap,),
        ),
        ]
              )

            ],
          ),
        ),
      ),
    ), child: Container(),
    );
  }

  logout() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", 0);
    await prefs.setString("user_name", "");
    await prefs.setString("user_member_id", "");
    await prefs.setString("user_mobile", "");
    await prefs.setString("user_status","");
    await prefs.setInt("shop_id", 0);
    await prefs.setString("shop_name", "");
    await prefs.setString("shop_mobile", "");
    await prefs.setString("shop_status", "");
    await prefs.setBool("is_logged_in", false);
    await prefs.setBool("is_president", false);

    Get.offAll(const LoginScreen());
  }

}
