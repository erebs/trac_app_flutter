import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../contants/app_colors.dart';

class BlurLoader extends StatelessWidget {
  const BlurLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Blur(
      blur: 1.5,
      blurColor: AppColors.semiTransparent,
      overlay: Center(
        child: Container(
          decoration:   BoxDecoration(
              color: AppColors.fontOnSecondary,
              border: Border.all(width: 0, color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(45)
          ),
          height: 45,
          width: 45,
          padding: const EdgeInsets.all(8),
          child: const CircularProgressIndicator(color: AppColors.primary,),
        ),
      ), child: Container(),
    );
  }
}






