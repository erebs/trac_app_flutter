import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac_app/views/pages/mainscreen/main_screen.dart';
import 'package:trac_app/views/pages/splashscreen/splash_screen.dart';

import '../contants/app_colors.dart';
import '../contants/app_variables.dart';
import '../models/shop_model.dart';
import '../models/user_model.dart';
import '../utils/snackbar.dart';
import '../views/pages/webscreen/web_screen.dart';

class PayController extends GetxController {
  var isLoading = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(String shopId) async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getInt("user_id").toString();
      String userName = prefs.getString("user_name")!;
      String userEmail = "${prefs.getString("user_mobile")!}@trackerala.com";
      String userMobile = prefs.getString("user_mobile")!;

      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}pay')!, body:
      {
        'user_id': userId,
        'shop_id': shopId,
        'amount': "300",
        'purpose': "Trac Premium Subscription",
        'phone': userMobile,
        'name': userName,
        'email': userEmail,
      });
      if (response.statusCode == 200) {
        ///data successfully
        bool status = jsonDecode(response.body)['status'];
        String message = jsonDecode(response.body)['message'];
        if(status)
          {
            String paymentUrl = jsonDecode(response.body)['payment_url'];
            Get.to(WebScreen( url: paymentUrl,));
          }else {
          Snack.show("", message);
        }

      } else {
        Snack.show("Api Error", "Something went wrong!");
      }
    } catch (e) {
      Snack.show("Catch Error!", e.toString());
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }






}