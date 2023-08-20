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

class LoginController extends GetxController {
  var isLoading = false.obs;
  late UserModel userModel;
  late User user;
  late Shop shop;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(String userMobileNumber,String password, String shopNumber) async {
    try {
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}login')!, body:
      {
        'username': userMobileNumber,
        'password': password,
        'shop_number': shopNumber,
      });
      if (response.statusCode == 200) {
        ///data successfully
        userModel = UserModel.fromJson(jsonDecode(response.body));

        if(userModel.status!)
          {
            user =  userModel.user!;
            shop =  userModel.shop!;

            if(userModel.isActive!)
              {setUserData();
              }else {
              Snack.show("User is not active!", "Please contact the administrator.");
                }

          }else {
          Snack.show("", userModel.message!);
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



  Future<void> setUserData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("user_id", user.id!);
    await prefs.setString("user_name", user.name!);
    await prefs.setBool("is_president", user.isPresident==1?true:false);
    await prefs.setString("user_member_id", user.memberId!);
    await prefs.setString("user_mobile", user.mobileNumber!);
    await prefs.setString("user_status", user.status!);
    await prefs.setInt("shop_id", shop.id!);
    await prefs.setString("shop_name", shop.shopName!);
    await prefs.setString("shop_mobile", shop.mobileNumber!);
    await prefs.setString("shop_status", shop.status!);
    await prefs.setBool("is_logged_in", true);

    Get.off( MainScreen());
  }


}