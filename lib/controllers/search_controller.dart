import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac_app/views/pages/mainscreen/main_screen.dart';
import 'package:trac_app/views/pages/splashscreen/splash_screen.dart';

import '../contants/app_colors.dart';
import '../contants/app_variables.dart';
import '../models/search_model.dart';
import '../models/shop_model.dart';
import '../models/user_model.dart';
import '../utils/snackbar.dart';

class SearchFraudsController extends GetxController {
  var isLoading = false.obs;
  late SearchModel searchModel;
  var frauds = <Frauds>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(String Query) async {
    try {
      isLoading(true);
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}search_fraud')!, body:
      {
        'query': Query,
      });

      if (response.statusCode == 200) {
        ///data successfully
        searchModel = SearchModel.fromJson(jsonDecode(response.body));
        frauds.value = searchModel.frauds!;

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