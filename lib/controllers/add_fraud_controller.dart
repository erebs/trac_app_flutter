import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac_app/models/subscription_check_model.dart';
import 'package:trac_app/views/pages/frauddetailscreen/fraud_detail_screen.dart';
import '../contants/app_variables.dart';
import 'dart:io';

import '../models/fraud_add_model.dart';
import '../utils/snackbar.dart';


class AddFraudController extends GetxController {
  var isLoading = false.obs;
  late FraudAddModel fraudAddModel;
  late Fraud fraud;

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  fetchData(String name, String mobile, String address, String ptype, String pdetails, String des, String image,BuildContext context) async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String shopId = prefs.getInt("shop_id").toString();
      var request = http.MultipartRequest('POST', Uri.parse('${AppVariables.apiUrl}fraud_create'));
      request.fields.addAll({
        'shop_id': shopId,
        'name': name,
        'mobile_number': mobile,
        'address': address,
        'proof_type': ptype,
        'proof_number': pdetails,
        'description': des,
        'images_id': '2321456'
      });
      request.files.add(await http.MultipartFile.fromPath('profile_photo', image));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        fraudAddModel = FraudAddModel.fromJson(jsonDecode(res));
        bool? status = fraudAddModel.status;
        String? msg = fraudAddModel.message;
        Snack.show("",msg!);

        if (kDebugMode) {
          print(msg!);
        }
        if(status!)
          {
            fraud = fraudAddModel.fraud!;
            String fId = fraud.id.toString();
            Get.off(FraudDetailScreen(fId: fId));
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