import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:trac_app/contants/app_colors.dart';
import 'package:trac_app/contants/app_variables.dart';
import 'package:trac_app/views/pages/frauddetailscreen/fraud_detail_screen.dart';
import '../../../contants/app_images.dart';
import 'package:intl/intl.dart';

import '../pages/webscreen/web_screen.dart';

class FraudCard extends StatelessWidget {
  FraudCard({
    super.key,
    required this.fId,
    required this.name,
    required this.date,
    required this.mobile,
    required this.address,
    required this.description,
    required this.image,

  });

  String name, date, mobile, address, description, image, fId;

  @override
  Widget build(BuildContext context) {

    DateTime dateTime = DateTime.parse(date).toLocal();
    String formattedDate = DateFormat.yMd().format(dateTime);

    return TouchableOpacity(
      onTap: () {
        Get.to(FraudDetailScreen( fId: fId,));
      },
      child: Container(
          height: 180,
          margin: const EdgeInsets.only(top: 15),
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
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 14),),
                  Text(
                    formattedDate,
                    style: const TextStyle(height: 1, fontWeight: FontWeight.bold,color: Colors.grey, fontSize: 12,),
                  ),
                ],
              ),

              SizedBox( height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: SizedBox(
                        height: 100,
                        width: 100,
                        child: image.isNotEmpty?Image.network(
                          fit: BoxFit.cover,
                            "${AppVariables.baseUrl}uploads/frauds/$image"):
                            Image.asset(AppImages.fraudPlaceholder,)
                    ),
                  ),

                  const SizedBox( width: 15,),

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
                          "Description",
                          style: TextStyle( fontWeight: FontWeight.w400,color: Colors.black87, fontSize: 10,),
                        ),
                        SizedBox( height: 2,),

                        Text(
                          description,
                          maxLines: 1,
                          style: const TextStyle(height: 1,
                              fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 13),),
                        SizedBox(height:10),

                      ],
                    ),
                  ),


                ],
              ),



            ],
          )
      ),
    );
  }
}
