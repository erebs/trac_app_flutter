import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trac_app/views/widgets/shimmers/widgets/notifications.dart';


class NotificationShimmer extends StatelessWidget {
  NotificationShimmer({
    super.key,
  });

  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        ShimmerNotificationCard(),
        ShimmerNotificationCard(),
        ShimmerNotificationCard(),
        ShimmerNotificationCard(),
        ShimmerNotificationCard(),
        ShimmerNotificationCard(),


      ],
    );
  }
}
