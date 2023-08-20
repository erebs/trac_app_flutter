import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:remixicon/remixicon.dart';
import 'package:trac_app/contants/app_colors.dart';
import 'package:trac_app/models/ushopmodel.dart';
import 'package:trac_app/views/widgets/loaders/blur_loader.dart';
import 'package:trac_app/views/widgets/shops.dart';

import '../../../contants/app_variables.dart';
import '../../../controllers/fbshop_controller.dart';
import '../../../controllers/ushop_controller.dart';
import '../webscreen/web_screen.dart';

class MyShopsScreen extends StatefulWidget {
  MyShopsScreen({
    super.key,
    required this.userId,
  });


  final String userId;

  @override
  State<MyShopsScreen> createState() => _MyShopsScreenState();
}

class _MyShopsScreenState extends State<MyShopsScreen> {

  final UShopController uShopController = Get.put(UShopController());

  @override
  Widget build(BuildContext context) {

    uShopController.fetchData();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
        onPressed: (){
          Get.to( WebScreen(url: "${AppVariables.baseUrl}member/add-shop/${widget.userId}" ,));
        },
          child: const Icon(Remix.add_line),),
      backgroundColor:AppColors.inputBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: const Text('My Shops', style: TextStyle(fontSize: 14),),
        ),

        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          color: AppColors.inputBackgroundColor,
          child: Obx(
                  () => uShopController.isLoading.value?const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: uShopController.shops?.length ?? 0,
                  itemBuilder: (context, i)
                  {
                    Shops shops = uShopController.shops[i];
                    return ShopCard(shopId: shops.id.toString(), name: shops.shopName??"", mobile: shops.mobileNumber!??"",
                      address: shops.shopAddress??"", pincode: shops.pincode??"", district: shops.district??"",
                      constituency: shops.constituency??"", senddate: shops.subscriptionEndDate??"",
                      isActive: shops.subscriptionStatus=="Active"?true:false, date: shops.createdAt??"",
                     );
                  }
              )
          ),
        )
    );
  }
}
