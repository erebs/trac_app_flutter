import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac_app/models/fraud_detail_model.dart';
import 'package:trac_app/models/subscription_check_model.dart';
import '../contants/app_variables.dart';
import '../utils/snackbar.dart';
import 'dart:io';


class FraudDetailController extends GetxController {
  var isLoading = false.obs;
  late FraudsDetailModel fraudsDetailModel;
  FraudDetails? fraudDetails;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(String fId) async {
    try {
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}fraud-details')!, body:
      {
        'fraud_id': fId,
      });
      if (response.statusCode == 200) {
        ///data successfully
        fraudsDetailModel = FraudsDetailModel.fromJson(jsonDecode(response.body));

        if(fraudsDetailModel.status!)
        {
          fraudDetails =  fraudsDetailModel.fraudDetails;

        }else {
          Snack.show("", fraudsDetailModel.message!);
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