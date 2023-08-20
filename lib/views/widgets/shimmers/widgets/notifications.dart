import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class ShimmerNotificationCard extends StatelessWidget {
  ShimmerNotificationCard({
    super.key,
    this.isLast = false,
  });

  bool isLast;
  Random random = Random();

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: isLast?const EdgeInsets.only(top: 10.0, bottom: 10.0 ):
      const EdgeInsets.only(top: 10.0, bottom: 10.0 ),
      child: TouchableOpacity(
        child: Container(
            height: 140,
            padding: const EdgeInsets.all(22),
            width: double.infinity,
            decoration:  const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(22))
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade400,
              enabled: true,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 0),
                        color: Colors.grey,
                        height:11,
                        width: random.nextInt(50) + 100,
                      ),
                      SizedBox( height: 11,),

                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        color: Colors.grey,
                        height:9,
                        width: random.nextInt(150) + 200,
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 7),
                        color: Colors.grey,
                        height:9,
                        width: random.nextInt(150) + 200,

                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 7),
                        height:9,
                        color: Colors.grey,
                        width: random.nextInt(60) + 100,

                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 7),
                        color: Colors.grey,
                        height:9,
                        width: random.nextInt(210) + 10,
                      ),
                    ],
                  ),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5),
                      color: Colors.grey,
                      height:10,
                      width: random.nextInt(50) + 30,
                    ),
                  ),

                ],
              ),
            )
        ),
      ),
    );
  }
}