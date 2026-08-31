import 'package:cci_app/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cci_app/collecte/collecte_screen.dart';
import 'package:cci_app/services/loc_service.dart';
import 'package:cci_app/services/dowar_services.dart';
import 'package:cci_app/nouvelle_douar/n_douar_screen.dart';
import 'package:geolocator/geolocator.dart';

import 'confirm-block.dart';

class ConfirmPage extends StatelessWidget {

  final IntervalService IS = Get.put(IntervalService());
  final DowarService DS = Get.put(DowarService());
  String? DowarID;
  ConfirmBlock confirmBlock = Get.put(ConfirmBlock());
  String Dname;
  ConfirmPage({
    required this.Dname
  });



  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Center(
            child: Text("Notre base de données connaît déjà cet endroit sous le nom  ${Dname}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F8A74),
                    fontSize: 28)),
          ),
          SizedBox(width: getProportionateScreenWidth(30)),
          Center(
            child: Text("Confirmez vous qu'il s'agit bien du même village?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F8A74),
                    fontSize: 18)),
          ),
          _buildconfirmButton(),
          _buildcautrevillButton()

        ],
      ));
  }

  Widget _buildconfirmButton() {
    return Container(
        padding: EdgeInsets.only(
            top: getProportionateScreenHeight(
                250)), // set padding to move button to top left corner
        child: ElevatedButton(
          onPressed: () async {
            DowarID = (await DS.retrieveDowarID(await IS.isDouarExist()))!;
            Get.to(() => CollectePage());
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF0F8A74)), // set background color
            minimumSize: MaterialStateProperty.all<Size>(
                const Size(250, 50)), // set minimum size
            // You can also use fixedSize property to set the exact button size
          ),
          child:  const Text("Confirmer",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
        ));
  }
  Widget _buildcautrevillButton() {
    return Container(
        padding: EdgeInsets.only(
            top: getProportionateScreenHeight(
                50)), // set padding to move button to top left corner
        child: ElevatedButton(
          onPressed: () async {
            Position currentPosition = await IS.getCurrentLocation();
            Get.to(() => N_douarPage(currentPosition: currentPosition));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF0F8A74)), // set background color
            minimumSize: MaterialStateProperty.all<Size>(
                const Size(250, 50)), // set minimum size
            // You can also use fixedSize property to set the exact button size
          ),
          child:  const Text("Autre village",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
        ));
  }
}
