import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac_app/contants/app_colors.dart';
import 'package:trac_app/contants/app_images.dart';
import 'package:get/get.dart';
import 'package:trac_app/controllers/notification_controller.dart';
import 'package:trac_app/views/pages/addfraudscreen/add_fraud_screen.dart';
import 'package:trac_app/views/pages/searchscreen/search_screen.dart';
import 'package:trac_app/views/widgets/loaders/dummy_home_loader.dart';
import 'package:trac_app/views/widgets/notifications.dart';
import '../../../../contants/app_variables.dart';
import '../../../../models/notifications_model.dart';
import '../../../widgets/inputs.dart';
import '../../../widgets/shimmers/notification_shimmer.dart';
import '../../webscreen/web_screen.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  String? userName;
  int? userId;
  TextEditingController searchController = TextEditingController();
  final NotificationController notificationController = Get.put(NotificationController());



  @override
  Widget build(BuildContext context) {

    List<BannerModel> listBanners = [
      BannerModel( id: "1", imagePath: 'https://images.unsplash.com/photo-1617854818583-09e7f077a156?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1170&q=80'),
      BannerModel( id: "2", imagePath: 'https://images.unsplash.com/photo-1624555130581-1d9cca783bc0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1171&q=80'),
      // BannerModel( id: "3", imagePath: ''),
      // BannerModel( id: "4", imagePath: ''),
      // BannerModel( id: "5", imagePath: ''),

    ];

    return FutureBuilder(
      future: getUserData(),
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is still loading, show a loading indicator.
          return const DummyHome();
        } else if (snapshot.hasError) {
          // If there was an error fetching the data, display an error message.
          return Text('Error: ${snapshot.error}');
        } else {

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: ()
                async {
                  var result = await Get.to(const AddFraudScreen());
                  if (result != null && result=="Refresh") {
                    notificationController.fetchData(userId.toString());
                }

              },
              child: Icon(Remix.user_add_fill),
              backgroundColor: AppColors.primary,
            ),
            backgroundColor: AppColors.inputBackgroundColor,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 170,
                    padding: const EdgeInsets.all(20),
                    decoration:  const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
                    ),
                    child: Column(
                      children: [
                        //Logo
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              SizedBox(
                                  height: 52,
                                  width: 52,
                                  child: Image.asset(AppImages.logo, color: AppColors.fontOnSecondary,)
                              ),
                              const SizedBox(width: 10,),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Hi $userName, Welcome to\n",
                                      style: const TextStyle(fontWeight: FontWeight.bold,color: AppColors.fontOnSecondary, fontSize: 12),),
                                    const TextSpan(
                                      text: 'Tools Rental Association\nfor Care',
                                      style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.fontOnSecondary, fontSize: 15,),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SearchDummyBox(
                          onPressed: () {
                            Get.to(SearchScreen());
                          },
                          hint: 'Search bad customers...',)

                      ],
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox( height: 20,),

                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BannerCarousel.fullScreen(
                                  banners: listBanners,
                                  customizedIndicators: const IndicatorModel.animation(
                                      width: 8, height: 8, spaceBetween: 1, widthAnimation: 8),
                                  height: 160,
                                  activeColor: AppColors.primary,
                                  disableColor: Colors.grey,
                                  animation: true,
                                  borderRadius: 20,
                                  indicatorBottom: false,
                                ),
                              ),

                              SizedBox( height: 20,),


                              const Text(
                                "Recent Notifications",
                                style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 18,),
                              ),

                              Obx(
                                      () => notificationController.isLoading.value?NotificationShimmer()
                                      : ListView.builder(
                                        shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: notificationController.notifications?.length ?? 0,
                                      itemBuilder: (context, i)
                                      {
                                        Notifications notification = notificationController.notifications[i];
                                        return NotificationCard
                                          (title: notification.title.toString(),
                                            content: notification.message.toString(),
                                            isLast:notificationController.notifications.length==(i+1)?true:false,
                                            onTap: () {
                                              Get.to( WebScreen(url: "${AppVariables.baseUrl}notification-details/${notification.id.toString()}" ,));
                                            },
                                            dateTimeValue: notification.updatedAt.toString());
                                      }
                                  )
                              ),

                              const SizedBox( height: 20,)


                            ],
                          ),
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          );

        }

      },
    );


  }

  getUserData () async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('user_name')!;
    userId = prefs.getInt('user_id')!;
    notificationController.fetchData(userId.toString());

  }

}
