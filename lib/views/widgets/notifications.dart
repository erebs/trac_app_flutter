import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../../contants/app_colors.dart';
import '../../utils/helpers.dart';


class NotificationCard extends StatelessWidget {
  NotificationCard({
    super.key,
    required this.title,
    required this.content,
    required this.onTap,
    this.isLast = false,
    required this.dateTimeValue,
  });

  String title, content, dateTimeValue;
  VoidCallback onTap;
  bool isLast;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: isLast?const EdgeInsets.only(top: 10.0, bottom: 10.0 ):
      const EdgeInsets.only(top: 10.0, bottom: 10.0 ),
      child: TouchableOpacity(
        onTap: () {
          showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
              ),
              builder: (BuildContext context){
                return Container(
                    margin: const EdgeInsets.only(top: 5),
                    padding: const EdgeInsets.symmetric( horizontal: 25, vertical: 30),
                    child: Text.rich(
                      textAlign: TextAlign.justify,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "$title\n",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,color: AppColors.fontOnWhite, fontSize: 16),),

                          TextSpan(
                            text: "\n",
                            style: const TextStyle(height: 0.4, fontWeight: FontWeight.bold,color: Colors.grey, fontSize: 20,),
                          ),

                           TextSpan(
                            text: '$content',

                            style: TextStyle(height: 1.1, fontWeight: FontWeight.w400 ,color: AppColors.fontOnWhite, fontSize: 15,),
                          ),

                        ],
                      ),
                    ),
                );
              }
          );
        },
        child: Container(
            height: 140,
            padding: const EdgeInsets.all(22),
            width: double.infinity,
            decoration:  const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(22))
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:15,
                            color: Colors.black
                        )),
                    SizedBox( height: 3,),

                    Text(Helpers.truncateString(content, 150),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize:14,
                            color: Colors.black.withOpacity(0.8)
                        )),
                  ],
                ),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Text( Helpers.timeAgoFromIsoString(dateTimeValue),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize:14,
                          color: Colors.grey
                      )),
                ),

              ],
            )
        ),
      ),
    );
  }
}