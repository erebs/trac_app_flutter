import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class SearchShimmer extends StatelessWidget {
  SearchShimmer({
    super.key,
  });

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
      children: [Expanded(
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey.shade900),
                        top: BorderSide(width: 1, color: Colors.grey.shade900),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
                    child: Container(
                      color: Colors.grey,
                      height:10,
                      width: random.nextInt(80) + 160,
                    ),
                  ),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                  SingleListShimmer(shimWidth: random.nextInt(80) + 160,),
                ],
              ),
            ),
          )
      ),
      ]
    );
  }
}

class SingleListShimmer extends StatelessWidget {
  SingleListShimmer({
    super.key,
    this.shimWidth = 40,
  });

  double shimWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.grey.shade900),
        ),
      ),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 0),
      child: Container(
        color: Colors.grey,
        height:10,
        width: shimWidth,
      ),
    );
  }
}