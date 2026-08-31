library config.globals;

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
  double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = Get.size.height;
    // 812 is the layout height that designer use
    return (inputHeight / 926) * screenHeight;
  }

// Get the proportionate height as per screen size
  double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = Get.size.width;
    // 375 is the layout width that designer use
    return (inputWidth / 428) * screenWidth;
  }
double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double height10px(BuildContext context) {
  return MediaQuery.of(context).size.height * .01;
}

double width10px(BuildContext context) {
  return MediaQuery.of(context).size.width * .026;
}

double iconSize10(BuildContext context) {
  return MediaQuery.of(context).size.width * .023;
}

double fontSize10(BuildContext context) {
  return MediaQuery.of(context).size.width * .024;
}
