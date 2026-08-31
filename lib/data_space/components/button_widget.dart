


import 'package:cci_app/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {super.key,
      required this.buttonLable,
      required this.buttonOnClickFunction});

  final String buttonLable;
  final Function() buttonOnClickFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
        // padding:  EdgeInsets.only(
            // left: getProportionateScreenWidth(10), top: getProportionateScreenHeight(10)), // set padding to move button to top left corner
        child: ElevatedButton(
          onPressed: buttonOnClickFunction,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF0F8A74)), // set background color
            minimumSize: MaterialStateProperty.all<Size>(
                 Size(getProportionateScreenWidth(193), getProportionateScreenHeight(50))), // set minimum size
            // You can also use fixedSize property to set the exact button size
          ),
          child: Text(buttonLable, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        ));
  }
}
