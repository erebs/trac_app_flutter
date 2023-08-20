import 'package:flutter/material.dart';

class Helpers
{
  static String timeAgoFromIsoString(String isoDateTimeStr) {
    DateTime dateTime = DateTime.parse(isoDateTimeStr);
    Duration timeDifference = DateTime.now().toUtc().difference(dateTime.toUtc());

    if (timeDifference.inDays >= 1) {
      return '${timeDifference.inDays} ${timeDifference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (timeDifference.inHours >= 1) {
      return '${timeDifference.inHours} ${timeDifference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (timeDifference.inMinutes >= 1) {
      return '${timeDifference.inMinutes} ${timeDifference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return '${timeDifference.inSeconds} ${timeDifference.inSeconds == 1 ? 'second' : 'seconds'} ago';
    }
  }


  static String truncateString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return "${text.substring(0, maxLength)} ...";
    }
  }


}