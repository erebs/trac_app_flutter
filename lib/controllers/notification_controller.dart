import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac_app/models/notifications_model.dart';
import 'package:trac_app/views/pages/mainscreen/main_screen.dart';
import 'package:trac_app/views/pages/splashscreen/splash_screen.dart';

import '../contants/app_colors.dart';
import '../contants/app_variables.dart';
import '../models/shop_model.dart';
import '../models/user_model.dart';
import '../utils/snackbar.dart';

class NotificationController extends GetxController {
  var isLoading = false.obs;
  late NotificationModel notificationModel;
  var notifications = <Notifications>[].obs; // The observable list of countries

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(String userId) async {
    try {
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.get(Uri.tryParse(
          '${AppVariables.apiUrl}notifications/$userId')!);
      if (response.statusCode == 200) {
        ///data successfully
        notificationModel = NotificationModel.fromJson(jsonDecode(response.body));

        if(notificationModel.status!)
          {
            notifications.value =  notificationModel.notifications!;

          }else {
          Snack.show("", notificationModel.message!);
        }

      } else {
        Snack.show("Api Error", "Something went wrong!$userId");
      }
    } catch (e) {
      Snack.show("Catch Error!", e.toString());
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }



  // Future<void> setUserData() async {
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt("user_id", user.id!);
  //   await prefs.setString("user_name", user.name!);
  //   await prefs.setString("user_member_id", user.memberId!);
  //   await prefs.setString("user_mobile", user.mobileNumber!);
  //   await prefs.setString("user_status", user.status!);
  //   await prefs.setInt("shop_id", shop.id!);
  //   await prefs.setString("shop_name", shop.shopName!);
  //   await prefs.setString("shop_mobile", shop.mobileNumber!);
  //   await prefs.setString("shop_status", shop.status!);
  //   await prefs.setBool("is_logged_in", true);
  //
  //   Get.off(const MainScreen());
  // }


}