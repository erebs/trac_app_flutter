import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac_app/contants/app_colors.dart';
import 'package:get/get.dart';
import 'package:trac_app/controllers/fbshop_controller.dart';
import '../../../../contants/app_images.dart';
import '../../../../models/fbshop_model.dart';
import '../../../widgets/frauds_card.dart';
import '../../../widgets/loaders/dummy_fnp_loader.dart';
import '../../../widgets/loaders/dummy_frads_loader.dart';
import '../../../widgets/shimmers/search_fraud_shimmer.dart';
import '../../addfraudscreen/add_fraud_screen.dart';

class FraudsScreen extends StatelessWidget {
  FraudsScreen({super.key});

  final FBShopController fbShopController = Get.put(FBShopController());

  @override
  Widget build(BuildContext context) {

    fbShopController.fetchData();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        async {
          Get.to(const AddFraudScreen());
        },
        child: Icon(Remix.user_add_fill),
        backgroundColor: AppColors.primary,
      ),
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
                                text: 'Bad Customers',
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
                                  () => fbShopController.isLoading.value?const FraudCardShimmer()
                                      : ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: fbShopController.frauds?.length ?? 0,
                                      itemBuilder: (context, i)
                                      {
                                        Frauds fraud = fbShopController.frauds[i];
                                        return FraudCard(
                                          name: fraud.name.toString(), date: fraud.createdAt.toString(),
                                          mobile: fraud.mobileNumber.toString(), address: fraud.address.toString(),
                                          description: fraud.description.toString(), image: fraud.profilePhoto.toString(),
                                          fId: fraud.id.toString(),);
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



}


