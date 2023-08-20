import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../contants/app_colors.dart';

class Snack{
   static void show(String title,String message) {

    Get.rawSnackbar(
      snackPosition: SnackPosition.TOP,
      messageText:Text(message, style: TextStyle(fontWeight: FontWeight.bold),),
      borderColor: AppColors.primary,
      borderRadius: 10,
      borderWidth: 2,
      backgroundColor: AppColors.fontOnSecondary,

    );
  }

}