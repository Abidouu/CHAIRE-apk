import 'package:cci_app/config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cci_app/quizz2/slider.dart';
import 'package:cci_app/data_space/dataspace_screen.dart';

import '../data_space/controllers/data_space_controller.dart';
import '../data_space/controllers/resonse_controller.dart';
import 'package:cci_app/models/responce.dart' as resp;
import 'package:cci_app/models/question.dart';
import 'package:cci_app/data_space/Providers/quizz2_provider.dart';


class Q2Page extends StatefulWidget {
  final String ? Dowarid;
  final List<Question> questions ;
  ValueProvider valueProvider;
  Q2Page({super.key, required this.Dowarid, required this.questions, required this.valueProvider});




  @override
  _Q2PageState createState() => _Q2PageState();
}

class _Q2PageState extends State<Q2Page> {
  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F8A74),
        title: const Text("Questions d'évaluations"),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      body: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getProportionateScreenHeight(10)),
                  for (var index= 0; index<widget.questions.length; index = index+1 ) ...[
                    MetricInterface(question: widget.questions[index], Dowarid: widget.Dowarid, valueProvider: widget.valueProvider,),
                     SizedBox(height: getProportionateScreenHeight(10)),

                  ]
                ],

              ),
            ]),
    );
  }



}
