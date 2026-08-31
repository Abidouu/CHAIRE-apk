import 'package:cci_app/config.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cci_app/data_space/dataspace_screen.dart';
import '../data_space/controllers/data_space_controller.dart';
import '../data_space/controllers/resonse_controller.dart';
import 'package:cci_app/quizz1/block.dart';
import 'package:cci_app/models/question.dart';
import 'package:cci_app/data_space/Providers/quizz1_provider.dart';

class Q1Page extends StatelessWidget {
  final String ? Dowarid;
  final List<Question> questions ;
  TextProvider textProvider;
  Q1Page({super.key, required this.Dowarid, required this.questions, required this.textProvider});

  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F8A74),
        title: const Text('Données générales'),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
          body: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(10)),
                    for (var index= 0; index<questions.length; index = index+1 ) ...[
                      writeResponse(question: questions[index], Dowarid: Dowarid, textProvider: textProvider),
                       SizedBox(height: getProportionateScreenHeight(10)),
                    ]
                  ],
                )


              ]),
    );
  }


}
