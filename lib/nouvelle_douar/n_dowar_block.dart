

import 'package:cci_app/models/dowar.dart';
import 'package:cci_app/services/dowar_services.dart';
import 'package:cci_app/models/intervale.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class NewDowarBlock extends GetxController{
  CoordinateInterval? coordinateInterval;



  saveDowar(String intervalID, String dowarName){
    Dowar dowar = Dowar();
    dowar.douwarId = const Uuid().v4();
    dowar.dowarName = dowarName;
    dowar.intervalId = intervalID;
    DowarService().saveDowar(dowar);
  }



}