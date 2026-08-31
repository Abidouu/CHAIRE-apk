import 'package:cci_app/config.dart';
import 'package:cci_app/models/question.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cci_app/quizz3/QCM_1.dart';
import 'package:cci_app/quizz3/QCM_2.dart';
import 'package:cci_app/quizz3/QCM_3.dart';
import 'package:cci_app/quizz3/QCM_4.dart';
import 'package:cci_app/quizz3/QCM_5.dart';
import 'package:cci_app/quizz3/QCM_6.dart';
import 'package:cci_app/quizz3/QCM_7.dart';
import 'package:cci_app/quizz3/QCM_8.dart';
import 'package:cci_app/quizz3/QCM_9.dart';
import 'package:cci_app/data_space/Providers/quizz3_provider.dart';

import '../data_space/controllers/data_space_controller.dart';
import '../data_space/controllers/resonse_controller.dart';

class Q3Page extends StatefulWidget {
  final String? Dowarid;

  ChoicesProvider choicesProvider;
  List<Question> questions = [
    Question(questionId: "iMQ6MPsxvL1gpzAQi782", questionType: "C", questionCorp: "Contexte local: géographique & infrastructure"),
    Question(questionId: "xLjXLLRVowRRxBUB1NAb", questionType: "C", questionCorp: "Cohésion sociale: Communauté et population"),
    Question(questionId: "rXWathnecJ0t9gqeLI5u", questionType: "C", questionCorp: "Cohésion sociale: Gouvernance et leadership"),
    Question(questionId: "O5NaT7YS99h7dy7DRPR0", questionType: "C", questionCorp: "Cohésion sociale: Culture et patrimoines"),
    Question(questionId: "RqCO7hrpKigeQkZgZVlU", questionType: "C", questionCorp: "Cohésion sociale: Inclusivité et solidarités"),
    Question(questionId: "wRxeCVupMCnx9xzfVYpi", questionType: "C", questionCorp: "Création de valeur: Transmission et éducation"),
    Question(questionId: "LsOhQgZWqZE5nFFpQCVT", questionType: "C", questionCorp: "Création de valeur: Echanges et travail"),
    Question(questionId: "Q6q3hcB6C6T7kP8yArnM", questionType: "C", questionCorp: "Création de valeur: Innovations et changement"),
    Question(questionId: "wkwn0nXrZKS3zAjt4VOC", questionType: "C", questionCorp: "Création de valeur: Ouverture et partenariats")
  ];

  Q3Page({Key? key, required this.Dowarid, required this.choicesProvider}) : super(key: key);

  @override
  _Q3PageState createState() => _Q3PageState();
}

class _Q3PageState extends State<Q3Page> {
  Responsecontroller responsecontroller = Get.put(Responsecontroller());

  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();
  Map<String, double> _selectedValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F8A74),
        title: const Text('Maturité de l’émergence'),
        // This drop-down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              ChooseTwoInOrderQuestion_1(question: widget.questions[0], Dowarid: widget.Dowarid, choicesProvider: widget.choicesProvider),
              SizedBox(height: 10),
              ChooseTwoInOrderQuestion_2(question: widget.questions[1], Dowarid: widget.Dowarid, choicesProvider: widget.choicesProvider),
              SizedBox(height: 10),
              ChooseTwoInOrderQuestion_3(question: widget.questions[2], Dowarid: widget.Dowarid, choicesProvider: widget.choicesProvider),
              SizedBox(height: 10),
              ChooseTwoInOrderQuestion_4(question: widget.questions[3], Dowarid: widget.Dowarid, choicesProvider: widget.choicesProvider),
              SizedBox(height: 10),
              ChooseTwoInOrderQuestion_5(question: widget.questions[4], Dowarid: widget.Dowarid, choicesProvider: widget.choicesProvider),
              SizedBox(height: 10),
              ChooseTwoInOrderQuestion_6(question: widget.questions[5], Dowarid: widget.Dowarid, choicesProvider: widget.choicesProvider),
              SizedBox(height: 10),
              ChooseTwoInOrderQuestion_7(question: widget.questions[6], Dowarid: widget.Dowarid, choicesProvider: widget.choicesProvider),
              SizedBox(height: 10),
              ChooseTwoInOrderQuestion_8(question: widget.questions[7], Dowarid: widget.Dowarid, choicesProvider: widget.choicesProvider),
              SizedBox(height: 10),
              ChooseTwoInOrderQuestion_9(question: widget.questions[8], Dowarid: widget.Dowarid, choicesProvider: widget.choicesProvider),
              SizedBox(height: 400),


            ],
          ),
        ),
      ),
    );
  }
}
