import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac_app/models/subscription_check_model.dart';
import '../contants/app_variables.dart';
import '../utils/snackbar.dart';
import 'dart:io';

import 'fraud_image_controller.dart';


class AddImageController extends GetxController {
  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(String fId, String image, FraudImageController fraudImageController,bool isProfImage) async {
    try {
      isLoading(true);
      String slug = isProfImage?"fraud-profImage-edit":"fraud_images_upload";
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String shopId = prefs.getInt("shop_id").toString();
      var request = http.MultipartRequest('POST', Uri.parse(
          '${AppVariables.apiUrl}$slug'));
      request.fields.addAll({
        'shop_id': shopId,
        'fraud_id': fId,
      });
      request.files.add(await http.MultipartFile.fromPath('images', image));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        if (kDebugMode) {
          print(res);
        }
        bool status = jsonDecode(res)['status'];
        String msg = jsonDecode(res)['message'];
        Snack.show("",msg);

        if(status)
          {
            if(isProfImage==false)
            {fraudImageController.fetchData(fId);}
          }
      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      Snack.show("Catch Error!", e.toString());
      debugPrint(e.toString());
    } finally {
      isLoading(false);
    }
  }


}