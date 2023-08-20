import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../contants/app_colors.dart';
import '../contants/app_variables.dart';
import '../models/shop_model.dart';
import '../utils/snackbar.dart';

class ShopController extends GetxController {
  var isLoading = false.obs;
  var shopList = <Shops>[].obs; // The observable list of countries

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(String userMobile) async {
    shopList.clear();
    try {
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}user_validation')!, body:
      {
        'username': userMobile,
      });
      if (response.statusCode == 200) {
        ///data successfully
        bool status = jsonDecode(response.body)['status'];
        String message = jsonDecode(response.body)['message'];
        if(status)
          {
            List<dynamic> shops  = jsonDecode(response.body)['shops'];
            shopList.value = shops.map((item) => Shops.fromJson(item)).toList();
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