
import 'package:blur/blur.dart';
import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:get/get.dart';
import 'package:trac_app/contants/app_variables.dart';
import 'package:trac_app/controllers/shop_controller.dart';
import 'package:trac_app/views/pages/webscreen/web_screen.dart';
import 'package:trac_app/views/widgets/shimmers/search_shimmer.dart';
import '../../../contants/app_colors.dart';
import '../../../contants/app_images.dart';
import '../../../controllers/login_controller.dart';
import '../../../models/shop_model.dart';
import '../../../utils/snackbar.dart';
import '../../widgets/buttons.dart';
import '../../widgets/inputs.dart';
import '../../widgets/loaders/blur_loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver{
  final ShopController shopController = Get.put(ShopController());
  final LoginController loginController = Get.put(LoginController());

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  RxString shopName = RxString("");
  String shopID = "0";
  String shopMobile = "0";

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {

    }
  }


  @override
  void initState(){
    super.initState();
    isPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
          child: Stack(
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 60),
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      SizedBox(
                          width: 100,
                          child: Image.asset(AppImages.logo)
                      ),
                      const SizedBox(height: 10,),
                      const Text(
                          "TOOL RENTAL ASSOCIATION\nFOR CARE (TRAC)",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: AppColors.fontOnSecondary,
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                          ))
                    ],
                  )
              ),

              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container (
                    decoration:  const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    ),
                    padding: const EdgeInsets.all(30),
                    width: double.infinity,
                    child: Wrap(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome back",
                              style: TextStyle(
                                  color: AppColors.fontOnWhite,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox( height: 2,),
                            const Text(
                              "Fill out the information below in order\nto access your account",
                              style: TextStyle(
                                  color: AppColors.fontOnWhite,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold
                              ),
                            ),

                            const SizedBox(height: 20),
                            const Text("Mobile number", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                            EditableBox(
                                controller: mobileController,
                                isEnabled: shopController.isLoading.value?false:true,
                                hint: "Enter your phone number",
                                onChanged: (value)
                              {
                              shopName.value = "";
                              value.length==10?shopController.fetchData(value):null;
                              },
                                type: TextInputType.phone,
                            ),

                            const SizedBox(height: 15),
                            const Text("Shops", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),

                            Obx(() => DropBox(
                              hint: "Choose your shop",
                              prefix: shopController.shopList.isNotEmpty?shopName.value:"",
                              onPressed: () {

                                shopController.shopList.length>0?
                                showModalBottomSheet(
                                    context: context,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16.0),
                                      ),
                                    ),
                                    builder: (BuildContext context){
                                      return Container(
                                          margin: const EdgeInsets.only(top: 25),
                                          child: ListView.builder(

                                              itemCount: shopController.shopList?.length ?? 0,
                                              itemBuilder: (context, i)
                                              {
                                                Shops shop = shopController.shopList[i];
                                                return TouchableOpacity(
                                                  onTap: (){
                                                    shopName.value = shop.shopName!;
                                                    shopID = shop.id.toString();
                                                    shopMobile = shop.mobileNumber.toString();
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(width: 1, color: Colors.black.withOpacity(0.08)),
                                                          bottom: BorderSide(width: 1, color: Colors.black.withOpacity(
                                                              shopController.shopList?.length==(i+1)?0.08:0.0)),
                                                        ),
                                                      ),
                                                      alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                                                      child:
                                                      Text("${shop.shopName}"??"",
                                                        style: TextStyle(fontSize: 13, color: Colors.black.withOpacity(0.6)),)
                                                  ),
                                                );
                                              }
                                          )
                                      );
                                    }
                                ):Snack.show("","Please enter valid mobile number");
                              },),
                            ),


                            const SizedBox(height: 15),
                            const Text("Password", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                            EditableBoxPass(
                                controller: passwordController,
                                isPassword: isPassword,
                                hint: "Enter your password",
                                onPressed: () {
                                  setState(() {isPassword = !isPassword;},);
                                },
                                type: TextInputType.visiblePassword),

                            const SizedBox(height: 15),

                            Align(
                              alignment: Alignment.topRight,
                              child: TouchableOpacity(
                                onTap: () {
                                  Get.to( WebScreen(url: "${AppVariables.baseUrl}member/reset-password" ,));
                                },
                                child: const Text("Forgot Password?",
                                    style: TextStyle(
                                        color:AppColors.fontOnWhite,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13
                                    )),
                              ),
                            ),

                            const SizedBox(height: 25),

                            PrimaryButton(
                              buttonText: 'Sign In',
                              onTap: () {
                                String userMobile = mobileController.text;
                                String userPassword = passwordController.text;
                                if (userMobile.length == 10 && userPassword.length >2 && shopID!="0")
                                  {
                                    loginController.fetchData(userMobile, userPassword, shopMobile);
                                  }else
                                    {
                                      Snack.show("", "Some requried fields are empty!");
                                    }
                              },

                            ),

                            const SizedBox(height: 8),

                            Center(
                              child: TouchableOpacity(
                                onTap: () {
                                   Get.to( WebScreen(url: "${AppVariables.baseUrl}member/register" ,));
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: "Don't have an account yet? "),
                                        TextSpan(
                                          text: 'Sign Up',
                                          style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 5),

                          ],
                        )],
                    ),
                  )
              ),

              Obx(() => SizedBox(
                  child: shopController.isLoading.value || loginController.isLoading.value?const BlurLoader():const SizedBox()
              ))
            ],

          )
      ),
    );
  }




}

