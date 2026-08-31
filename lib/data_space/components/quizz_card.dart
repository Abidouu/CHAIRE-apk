

import 'package:cci_app/config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';

class QuizzCard extends StatelessWidget {
  const QuizzCard(
      {super.key, required this.cardTitle, required this.cardDescription,required this.onClockFuction});

  final String cardTitle;
  final String cardDescription;
  final Function() onClockFuction;

  @override
  Widget build(BuildContext context) {
    
    return Container(
        // padding:  EdgeInsets.only(
        //     left: getProportionateScreenHeight(5), top: getProportionateScreenHeight(10),right:getProportionateScreenHeight(5) ), // set padding to move button to top left corner
        child: ElevatedButton(
          onPressed: onClockFuction,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF0F8A74)), // set background color
            minimumSize: MaterialStateProperty.all<Size>(
                 Size(getProportionateScreenWidth(190), getProportionateScreenHeight(250))), // set minimum size
            // You can also use fixedSize property to set the exact button size
          ),
          child: Container(
            height: getProportionateScreenHeight(240),
            width: getProportionateScreenWidth(160),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    children: [
                      WidgetSpan(
                      child: SizedBox(
                        width:getProportionateScreenWidth(160) ,
                        height: getProportionateScreenHeight(20),
                    ),
                  ),
                      TextSpan(
                        text: cardTitle,
                        style: TextStyle(
                          fontSize: 18, // Set the font size for the title
                          fontWeight: FontWeight.bold,
                        ),
                      )]
                  ),

                  TextSpan(
                    children: [
                      WidgetSpan(
                        child: SizedBox(
                          width: getProportionateScreenWidth(160),
                          height: getProportionateScreenHeight(40),
                        ),
                      ),
                      TextSpan(
                        text: '\n$cardDescription',
                        style: TextStyle(
                          fontSize: 14, // Set the font size for the description
                        ),
                      )]


                  ),
                ],
              ),
            ),
          )

        ));
  }
}


class QuizzCardPrime extends StatelessWidget {
  const QuizzCardPrime(
      {super.key, required this.cardTitle, required this.cardDescription,required this.onClockFuction});

  final String cardTitle;
  final String cardDescription;
  final Function() onClockFuction;

  @override
  Widget build(BuildContext context) {

    return Container(
      // padding:  EdgeInsets.only(
      //     left: getProportionateScreenHeight(5), top: getProportionateScreenHeight(10),right:getProportionateScreenHeight(5) ), // set padding to move button to top left corner
        child: ElevatedButton(
            onPressed: onClockFuction,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color(0xFF0F8A74)), // set background color
              minimumSize: MaterialStateProperty.all<Size>(
                  Size(getProportionateScreenWidth(190), getProportionateScreenHeight(250))), // set minimum size
              // You can also use fixedSize property to set the exact button size
            ),
            child: Container(
              height: getProportionateScreenHeight(240),
              width: getProportionateScreenWidth(160),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        children: [
                          WidgetSpan(
                            child: SizedBox(
                              width:getProportionateScreenWidth(160) ,
                              height: getProportionateScreenHeight(5),
                            ),
                          ),
                          TextSpan(
                            text: cardTitle,
                            style: TextStyle(
                              fontSize: 18, // Set the font size for the title
                              fontWeight: FontWeight.bold,
                            ),
                          )]
                    ),

                    TextSpan(
                        children: [
                          WidgetSpan(
                            child: SizedBox(
                              width: getProportionateScreenWidth(160),
                              height: getProportionateScreenHeight(10),
                            ),
                          ),
                          TextSpan(
                            text: '\n$cardDescription',
                            style: TextStyle(
                              fontSize: 13, // Set the font size for the description
                            ),
                          )]


                    ),
                  ],
                ),
              ),
            )

        ));
  }
}
