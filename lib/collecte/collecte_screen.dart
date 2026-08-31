import 'package:cci_app/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cci_app/data_space/dataspace_screen.dart';
import 'package:cci_app/services/loc_service.dart';
import 'package:cci_app/services/dowar_services.dart';

import 'collect-block.dart';

class CollectePage extends StatelessWidget {

  final IntervalService IS = Get.put(IntervalService());
  final DowarService DS = Get.put(DowarService());
  String? DowarID;
  CollectBlock collectBlock = Get.put(CollectBlock());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          body:
        collectBlock.isLoadingUserIfo.value ?
        const Center(child: CircularProgressIndicator(),)
        :Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Center(
            child: Text("Bonjour ${collectBlock.user!.firstname} ${collectBlock.user!.lastname}, Nous vous remercions pour votre collaboration.",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F8A74),
                    fontSize: 28)),
          ),
          SizedBox(width: getProportionateScreenWidth(30)),
          Center(
            child: Text('Veuillez appuyer sur "Continuer" pour commencer à enregistrer vos données terrain.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F8A74),
                    fontSize: 18)),
          ),
          _buildcollecteButton()
        ],
      )),
    );
  }

  Widget _buildcollecteButton() {
    return Container(
        padding: EdgeInsets.only(
            top: getProportionateScreenHeight(
                350)), // set padding to move button to top left corner
        child: ElevatedButton(
          onPressed: () async {
            Get.to(() => DataSpace());
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFF0F8A74)), // set background color
            minimumSize: MaterialStateProperty.all<Size>(
                const Size(250, 50)), // set minimum size
            // You can also use fixedSize property to set the exact button size
          ),
          child:  const Text("Continuer",
              textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
        ));
  }
}
