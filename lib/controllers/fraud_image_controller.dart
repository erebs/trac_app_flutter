import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac_app/models/fraud_image_controller.dart';
import 'package:trac_app/models/notifications_model.dart';
import 'package:trac_app/views/pages/mainscreen/main_screen.dart';
import 'package:trac_app/views/pages/splashscreen/splash_screen.dart';

import '../contants/app_colors.dart';
import '../contants/app_variables.dart';
import '../models/fbshop_model.dart';
import '../models/shop_model.dart';
import '../models/user_model.dart';
import '../utils/snackbar.dart';

class FraudImageController extends GetxController {
  var isLoading = false.obs;
  late FraudImageModel fraudImageModel;
  late List<String> images;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(String fId) async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String shopId = prefs.getInt("shop_id").toString();
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}fraud_images')!, body: {
        "fraud_id": fId,
      });
      if (response.statusCode == 200) {
        ///data successfully
        fraudImageModel = FraudImageModel.fromJson(jsonDecode(response.body));

        if(fraudImageModel.status!)
          {
            images =  fraudImageModel.images!;

          }else {
          Snack.show("", fraudImageModel.message!);
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