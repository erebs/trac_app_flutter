import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


import '../contants/app_variables.dart';
import '../models/fbshop_model.dart';
import '../models/ushopmodel.dart';
import '../utils/snackbar.dart';

class UShopController extends GetxController {
  var isLoading = false.obs;
  late UShopModel uShopModel;
  var shops = <Shops>[].obs; // The observable list of countries

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getInt("user_id").toString();
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}shops_by_user')!, body: {
        "user_id": userId,
      });
      if (response.statusCode == 200) {
        ///data successfully
        uShopModel = UShopModel.fromJson(jsonDecode(response.body));

        if(uShopModel.status!)
          {
            shops.value =  uShopModel.shops!;

          }else {
          Snack.show("", uShopModel.message!);
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