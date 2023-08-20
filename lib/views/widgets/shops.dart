import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:trac_app/contants/app_colors.dart';
import 'package:intl/intl.dart';

import '../../controllers/pay_controller.dart';

class ShopCard extends StatelessWidget {
  ShopCard({
    super.key,
    required this.shopId,
    required this.name,
    required this.mobile,
    required this.address,
    required this.pincode,
    required this.district,
    required this.constituency,
    required this.senddate,
    required this.isActive,
    required this.date,

  });

  String name, date, mobile, address, shopId,
      pincode, district, constituency, senddate;
  bool isActive;

  @override
  Widget build(BuildContext context) {

    final PayController payController = Get.put(PayController());

    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDate = DateFormat.yMd().format(dateTime);

    return Padding(
      padding: const EdgeInsets.only(top: 15),
    child: TouchableOpacity(
        onTap: (){
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
              ),
              builder: (BuildContext context){
                return Container(
                  margin: const EdgeInsets.only(top: 5),
                  padding: const EdgeInsets.symmetric( horizontal: 25, vertical: 30),
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                const Text(
                "Shop ID",
                style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                ),
                Text(
                "TRS$shopId",
                maxLines: 1,
                style: const TextStyle(height: 1,
                fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),

                const SizedBox( height: 5,),

                const Text(
                "Shop Name",
                style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                ),
                Text(
                maxLines: 1,
                name,
                style: const TextStyle(height: 1,
                fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),

                const SizedBox( height: 5,),

                const Text(
                "Mobile Number",
                style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                ),
                Text(
                mobile,
                maxLines: 1,
                style: const TextStyle(height: 1,
                fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),


                const SizedBox( height: 5,),

                const Text(
                "Pincode",
                style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                ),
                Text(
                pincode,
                maxLines: 1,
                style: const TextStyle(height: 1,
                fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),

                const SizedBox( height: 5,),

                const Text(
                "District",
                style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                ),
                Text(
                district,
                maxLines: 1,
                style: const TextStyle(height: 1,
                fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),


                const SizedBox( height: 5,),

                const Text(
                "Constituency",
                style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                ),
                Text(
                constituency,
                maxLines: 1,
                style: const TextStyle(height: 1,
                fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),

                const SizedBox( height: 5,),


                const Text(
                "Address",
                style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                ),
                Text(
                address,
                style: const TextStyle(height: 1,
                fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),

                const SizedBox( height: 5,),

                const Text(
                "Created on",
                style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                ),

                Text(
                formattedDate,
                maxLines: 1,
                style: const TextStyle(height: 1,
                fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),


                const SizedBox( height: 5,),

                const Text(
                "Subscription end on",
                style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                ),

                Text(
                senddate,
                maxLines: 1,
                style: const TextStyle(height: 1,
                fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),

                  SizedBox( height: 15,),

                  TouchableOpacity(
                      onTap: () { payController.fetchData(shopId); },
                      child:
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                          width: double.infinity,
                          decoration:  const BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Center(
                            child: Text(isActive?"Renew Subscription":"Get Subscription",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,color: AppColors.fontOnSecondary, fontSize: 14)
                            ),
                          )
                      )),

                SizedBox(height:10),

                ],
                  ));
              }
          );
        },
        child: Container(
            height: 180,
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration:  const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$name - (TRS$shopId)",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 14),),
                    Text(
                      isActive?"Premium":"No Subscription",
                      style: TextStyle(height: 1, fontWeight: FontWeight.bold,color: isActive?Colors.green:Colors.red, fontSize: 12,),
                    ),
                  ],
                ),

                SizedBox( height: 10,),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Mobile number",
                        style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                      ),
                      SizedBox( height: 2,),
                      Text(
                        mobile,
                        maxLines: 1,
                        style: const TextStyle(height: 1,
                            fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),

                      const SizedBox( height: 5,),

                      const Text(
                        "Address",
                        style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                      ),
                      SizedBox( height: 2,),

                      Text(
                        maxLines: 1,
                        address,
                        style: const TextStyle(height: 1,
                            fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),

                      const SizedBox( height: 5,),

                      const Text(
                        "Subcription ends on",
                        style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                      ),
                      SizedBox( height: 2,),

                      Text(
                        senddate,
                        maxLines: 1,
                        style: const TextStyle(height: 1,
                            fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),
                      SizedBox(height:10),




                    ],
                  ),
                ),



              ],
            )
        ),
      ),
    );
  }
}
