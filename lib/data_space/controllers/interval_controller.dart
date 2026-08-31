


import 'dart:io';

import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../models/intervale.dart';

class intervalController extends GetxController {
  CoordinateInterval creatintervale(double StartLatitude, double StartLongitude, double EndLatitude, double EndLongitude) {
    CoordinateInterval interval = CoordinateInterval(
        intervalId: const Uuid().v4().toString(),
        startLatitude: StartLatitude,
        startLongitude: StartLongitude,
        endLatitude: EndLatitude,
        endLongitude: EndLongitude );

    return  interval;

  }




}
