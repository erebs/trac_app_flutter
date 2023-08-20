import 'package:flutter/material.dart';
import 'package:trac_app/contants/app_colors.dart';
import 'package:get/get.dart';
import '../../../../contants/app_images.dart';
import '../../pages/searchscreen/search_screen.dart';
import '../inputs.dart';
import '../shimmers/notification_shimmer.dart';

class DummyHome extends StatelessWidget {
  const DummyHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.appBackgroundColor,
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
                          const Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: "Hi ...., Welcome to\n",
                                  style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.fontOnSecondary, fontSize: 12),),
                                TextSpan(
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
                      hint: 'Search frauds...',)

                  ],
                ),
              ),

              Expanded(
                child: Container(
                  child:  SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          const SizedBox( height: 20,),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              color: Colors.grey,
                              height: 160,
                              width: double.infinity,
                            )
                          ),

                          SizedBox( height:20),

                          const Text(
                            "Notifications",
                            style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 18,),
                          ),

                          NotificationShimmer(),

                          const SizedBox( height: 20,),



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
}