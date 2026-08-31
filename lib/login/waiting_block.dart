import 'package:cci_app/collecte/collecte_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../nouvelle_douar/n_douar_screen.dart';
import '../services/loc_service.dart';
import 'package:cci_app/confirmation/confirm_screen.dart';
import 'package:cci_app/services/dowar_services.dart';

class WaitingBlock extends GetxController {
  var isLoading = false.obs;
  final IntervalService IS = Get.put(IntervalService());
  final DowarService DS = Get.put(DowarService());

  void checkPosition() async {
    try {
      isLoading.value = true;
      Position? currentPosition = await IS.getCurrentLocation1();

      if (currentPosition != null && currentPosition.latitude != null && currentPosition.longitude != null) {
        String positionExist = await IS.isDouarExist();

        if (positionExist.isNotEmpty) {
          String dowarName = await DS.retrieveDowarname(positionExist);
          Get.offAll(() => ConfirmPage(Dname: dowarName));
        } else {
          Get.offAll(() => N_douarPage(currentPosition: currentPosition));
        }
      } else {
        // Handle the case when currentPosition is null or its latitude/longitude is null
        print('Current position is null or invalid');
        // You can display an error message or handle the null position accordingly
      }
    } catch (e) {
      // Handle any errors that occur during the position check
      print('Error checking position: $e');
      // You can display an error message or handle the error accordingly
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    checkPosition();
  }
}
