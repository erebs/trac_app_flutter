import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:get/get.dart';
import 'package:trac_app/views/pages/loginscreen/login_screen.dart';
import 'package:trac_app/views/pages/myshopscreen/myshops_screen.dart';
import 'package:trac_app/views/pages/reset_password/reset_screen.dart';
import '../../../../contants/app_colors.dart';
import '../../../../contants/app_images.dart';
import '../../../../contants/app_variables.dart';
import '../../webscreen/web_screen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key,
    this.userName = "",
    this.userMemberId = "",
    this.userId = "",
    this.shopId = "",
    this.isPresident = false,
  });

  String userName, userMemberId, userId, shopId;
  bool isPresident;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.appBackgroundColor,
          child: Column(
            children: [

              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  color: AppColors.primary,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: SizedBox(
                              height: 45,
                              width: 45,
                              child: Image.asset(AppImages.userImage,)
                          ),
                        ),

                        const SizedBox(width: 10,),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "$userName - ($userMemberId)\n",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,color: AppColors.fontOnSecondary, fontSize: 16),),
                              const TextSpan(
                                text: 'User Profile',
                                style: TextStyle(height: 1.4, fontWeight: FontWeight.bold,color: AppColors.fontOnSecondary, fontSize: 13,),
                              ),
                            ],
                          ),
                        ),

                      ]
                  )
              ),

              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      SizedBox( height:25),


                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(5),
                        decoration:  const BoxDecoration(
                            color: AppColors.fontOnSecondary,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Column(
                          children: [

                            ProfileMenuCard(
                              title: 'Edit Profile',
                              onTap: () {
                                Get.to( WebScreen(url: "${AppVariables.baseUrl}member/edit-profile/$userId" ,));
                              },
                              content: 'Edit your account details',
                              icon: Remix.edit_2_line,),

                            ProfileMenuCard(
                              title: 'Reset Password',
                              onTap: () {
                                Get.to( WebScreen(url: "${AppVariables.baseUrl}member/reset-password" ,));
                              },
                              content: 'Change your account password',
                              icon: Remix.lock_2_line,),

                            isPresident?ProfileMenuCard(
                              title: 'Members',
                              onTap: () {
                                Get.to( WebScreen(url: "${AppVariables.baseUrl}member/active-members/$userId" ,));
                              },
                              content: 'Activate members',
                              icon: Remix.user_4_line,):const SizedBox(),

                            ProfileMenuCard(
                              title: 'My Shops',
                              onTap: () { Get.to( MyShopsScreen(userId: userId));},
                              content: 'Manage your shop accounts',
                              icon: Remix.store_2_line,),

                            ProfileMenuCard(
                              onTap: () {
                                logout();
                              },
                              title: 'Logout',
                              content: 'Exit from this device',
                              icon: Remix.logout_circle_line,),

                          ],
                        ),
                      ),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Text(
                            "Others",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey, fontSize: 16,),
                          ),
                        ),
                      ),


                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(5),
                        decoration:  const BoxDecoration(
                            color: AppColors.fontOnSecondary,
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Column(
                          children: [

                            ProfileMenuCard(
                              title: 'About Us',
                              content: 'Know about TRAC',
                              onTap: () {
                                Get.to( WebScreen(url: "${AppVariables.baseUrl}member/aboutus" ,));
                              },
                              icon: Remix.information_line,),

                            ProfileMenuCard(
                              title: 'Contact Us',
                              content: 'Reach us for any help & support',
                              onTap: () {
                                Get.to( WebScreen(url: "${AppVariables.baseUrl}member/contact" ,));
                              },
                              icon: Remix.headphone_line,),


                            ProfileMenuCard(
                              title: 'Terms & Conditions',
                              content: 'General Terms & Conditions',
                              onTap: () {
                                Get.to( WebScreen(url: "${AppVariables.baseUrl}member/terms" ,));
                              },
                              icon: Remix.secure_payment_line,),

                            ProfileMenuCard(
                              title: 'Privacy Policy',
                              content: 'Know about your privacy',
                              onTap: () {
                                Get.to( WebScreen(url: "${AppVariables.baseUrl}member/privacy-policy" ,));
                              },
                              icon: Remix.eye_off_line,),

                            ProfileMenuCard(
                              title: 'FAQ',
                              content: 'Find answers to your queries',
                              onTap: () {
                                Get.to( WebScreen(url: "${AppVariables.baseUrl}member/faq" ,));
                              },
                              icon: Remix.question_line,),

                          ],
                        ),
                      ),

                      SizedBox( height: 20,)


                    ],
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
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

class ProfileMenuCard extends StatelessWidget {
  ProfileMenuCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    this.onTap,
  });

  String title, content;
  IconData icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          color: AppColors.fontOnSecondary,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                const SizedBox( width:10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    child: Container(
                      color: AppColors.primary.withOpacity(0.2),
                        height: 45,
                        width: 45,
                        child: Icon(icon, size: 22, color: AppColors.primary,)
                    ),
                  ),
                ),

                const SizedBox( width:20),

                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "$title\n",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 15),),
                        TextSpan(
                          text: content,
                          style: const TextStyle(height: 1.4, fontWeight: FontWeight.w600,color: Colors.black38, fontSize: 13,),
                        ),
                      ],
                    ),
                  ),
                ),


                const Align(
                  alignment: Alignment.centerRight,
                    child: Icon(Remix.arrow_right_s_line, size: 30, color: Colors.grey,))

              ]
          )
      ),
    );
  }
}
