import 'package:flutter/material.dart';
import 'package:trac_app/contants/app_colors.dart';

import '../../widgets/inputs.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreen();
}

class _ResetScreen extends State<ResetScreen> {

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword =true;
  bool isPassword2 = true;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.inputBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          title: const Text('Reset Password', style: TextStyle(fontSize: 14),),
        ),

        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Text("Mobile number", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                EditableBox(
                  controller: mobileController,
                  hint: "Enter your phone number",
                  onChanged: (value)
                  {

                  },
                  type: TextInputType.phone,
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
                const Text("Confirm Password", style: TextStyle(color: AppColors.fontOnWhite, fontSize: 12, fontWeight: FontWeight.bold)),
                EditableBoxPass(
                    controller: passwordController,
                    isPassword: isPassword2,
                    hint: "Confirm your password",
                    onPressed: () {
                      setState(() {isPassword2 = !isPassword2;},);
                    },
                    type: TextInputType.visiblePassword),

              ],
            ),
          ),
        )
    );
  }
}
