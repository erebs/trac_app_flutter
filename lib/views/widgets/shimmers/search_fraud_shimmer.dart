import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trac_app/views/widgets/shimmers/widgets/frauds_card_shimmer.dart';
import 'package:trac_app/views/widgets/shimmers/widgets/notifications.dart';


class FraudCardShimmer extends StatelessWidget {
  const FraudCardShimmer({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ShimmerFraudCard(),
        ShimmerFraudCard(),
        ShimmerFraudCard(),
        ShimmerFraudCard(),
        ShimmerFraudCard(),
        ShimmerFraudCard(),


      ],
    );
  }
}
