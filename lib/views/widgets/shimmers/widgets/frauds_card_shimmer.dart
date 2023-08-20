import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerFraudCard extends StatelessWidget {
  ShimmerFraudCard({
    super.key,
  });

  Random random = Random();


  @override
  Widget build(BuildContext context) {
    return Container(
        height: 180,
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        decoration:  const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade400,
          enabled: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    color: Colors.grey,
                    height:9,
                    width: random.nextInt(50) + 50,
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 0),
                    color: Colors.grey,
                    height:9,
                    width: random.nextInt(50) + 20,
                  ),
                ],
              ),

              SizedBox( height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      color: Colors.grey,
                      height: 90,
                        width: 90,
                    ),
                  ),

                  const SizedBox( width: 15,),

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          color: Colors.grey,
                          height:7,
                          width: 60,
                        ),
                        SizedBox( height: 4,),
                        Container(
                          margin: const EdgeInsets.only(top: 0),
                          color: Colors.grey,
                          height:9,
                          width: random.nextInt(50) + 100,
                        ),

                        const SizedBox( height: 9,),

                        Container(
                          margin: const EdgeInsets.only(top: 0),
                          color: Colors.grey,
                          height:7,
                          width: 80,
                        ),
                        SizedBox( height: 4,),
                        Container(
                          margin: const EdgeInsets.only(top: 0),
                          color: Colors.grey,
                          height:9,
                          width: random.nextInt(50) + 20,
                        ),

                        const SizedBox( height: 9,),

                        Container(
                          margin: const EdgeInsets.only(top: 0),
                          color: Colors.grey,
                          height:7,
                          width: 110,
                        ),
                        SizedBox( height: 4,),
                        Container(
                          margin: const EdgeInsets.only(top: 0),
                          color: Colors.grey,
                          height:9,
                          width: random.nextInt(150) + 200,
                        ),

                        SizedBox(height:10),

                      ],
                    ),
                  ),


                ],
              ),



            ],
          ),
        )
    );
  }
}