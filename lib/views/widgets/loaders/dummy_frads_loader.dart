import 'package:flutter/material.dart';
import 'package:trac_app/contants/app_colors.dart';

import '../../../../contants/app_images.dart';
import '../shimmers/notification_shimmer.dart';
import '../shimmers/search_fraud_shimmer.dart';

class DummyFrauds extends StatelessWidget {
  const DummyFrauds({
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
                                text: '...',
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
                    physics: ScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SizedBox( height:10),


                          FraudCardShimmer(),


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
}