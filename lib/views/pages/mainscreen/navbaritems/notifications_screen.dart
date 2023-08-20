import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../contants/app_colors.dart';
import '../../../../contants/app_images.dart';
import '../../../../contants/app_variables.dart';
import '../../../../controllers/notification_controller.dart';
import '../../../../models/notifications_model.dart';
import '../../../widgets/loaders/dummy_fnp_loader.dart';
import '../../../widgets/notifications.dart';
import '../../../widgets/shimmers/notification_shimmer.dart';
import '../../webscreen/web_screen.dart';

class NotificationsScreen extends StatelessWidget {
  NotificationsScreen({super.key});
  String? userName;
  int? userId;
  final NotificationController notificationController = Get.put(NotificationController());


  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getUserData(),
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While the future is still loading, show a loading indicator.
          return const Dummy();
        } else if (snapshot.hasError) {
          // If there was an error fetching the data, display an error message.
          return Text('Error: ${snapshot.error}');
        } else {

          return Scaffold(
            body: SafeArea(
              child: Container(
                color: AppColors.appBackgroundColor,
                child: Column(
                  children: [

                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        color: AppColors.primary,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Image.asset(AppImages.logo, color: AppColors.fontOnSecondary,)
                              ),

                              const SizedBox(width: 10,),
                              const Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "TRAC\n",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,color: AppColors.fontOnSecondary, fontSize: 18),),
                                    TextSpan(
                                      text: 'Notifications',
                                      style: TextStyle(height: 1.4, fontWeight: FontWeight.bold,color: AppColors.fontOnSecondary, fontSize: 13,),
                                    ),
                                  ],
                                ),
                              ),

                            ]
                        )
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

                  SizedBox( height:10),


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

                    SizedBox( height:10),

                ],
              ),
            ),
                ),
                ),
                )

                  ],
                ),
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
