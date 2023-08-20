import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:trac_app/models/subscription_check_model.dart';
import '../contants/app_variables.dart';
import '../utils/snackbar.dart';


class SubscriptionCheckController extends GetxController {
  var isLoading = false.obs;
  SubscriptionCheckModel subscriptionCheckModel = SubscriptionCheckModel();
  Subscription subscription = Subscription();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(String shopId) async {
    try {
      isLoading(true);
      FocusManager.instance.primaryFocus?.unfocus();
      http.Response response = await http.post(Uri.tryParse(
          '${AppVariables.apiUrl}subscription')!,body:
      {
        'shop_id': shopId,
      });
      if (response.statusCode == 200) {

        if (kDebugMode) {
          print(response.body);
        }

        subscriptionCheckModel = SubscriptionCheckModel.fromJson(jsonDecode(response.body));
        if(subscriptionCheckModel!.status!) {
          subscription = subscriptionCheckModel.subscription!;
        }
        // else {
        //  Snack.show("", subscriptionCheckModel.message!);
        // }

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