import 'package:cci_app/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cci_app/models/question.dart';
import 'package:cci_app/data_space/Providers/quizz3_provider.dart';
import 'package:cci_app/data_space/controllers/choices_Edditing_Controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cci_app/data_space/controllers/resonse_controller.dart';
import 'package:cci_app/models/responce.dart' as resp;
import 'package:cci_app/data_space/controllers/data_space_controller.dart';
import 'package:cci_app/services/loc_service.dart';
import 'package:cci_app/services/dowar_services.dart';
import 'package:cci_app/collecte/collecte_screen.dart';



class ChooseTwoInOrderQuestion_5 extends StatefulWidget {
  final Question question;
  final String? Dowarid;
  ChoicesProvider choicesProvider;


  ChooseTwoInOrderQuestion_5({
    required this.question,
    required this.Dowarid,
    required this.choicesProvider
  });

  @override
  _ChooseTwoInOrderQuestionState_5 createState() => _ChooseTwoInOrderQuestionState_5();
}

class _ChooseTwoInOrderQuestionState_5 extends State<ChooseTwoInOrderQuestion_5> {
  final IntervalService IS = Get.put(IntervalService());
  final CollectePage CP = Get.put(CollectePage());
  final DowarService DS = Get.put(DowarService());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();
  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  List<String> options = [    'Pré-Émergence',    'Émergence',    'Equilibre',    'Déclin', 'Effondrement', 'Non évalué'];
  List<String> Descriptions = [
    "Les membres de la communauté reconnaissent généralement que la solidarité est l’une de leurs valeurs traditionnelles et qu’elle est nécessaire à la cohésion collective. Une entraide minimale existe entre les habitants soit pour des tâches individuelles (entraide entre amis, voisins, ...) ou communautaires (dont la réalisation apporte de la valeur à l’ensemble). La solidarité s’exprime aussi en faveur des plus démunis lorsqu’un choc les atteint (maladie, décès, perte d’emploi, perte soudaine de revenus, sinistre, ...). Des groupes d’entraide financière (notamment féminins) existent parfois permettant à leur membre d’encaisser plus facilement des difficultés passagères, de réaliser des achats urgents et indispensables (santé, éducation, construction/rénovation, ...) ou de lancer des petits projets générateurs de revenus.",
    "La solidarité est visible dans le nombre de projets collectifs qui sont engagés dans lesquels on voit les habitants travailler et contribuer ensemble à la réalisation de nouvelles infrastructures ou à la transformation de nouvelles opportunités qui profiteront au plus grand nombre. Des projets qui ciblent les catégories défavorisés et à risque sont aussi lancés pour sortir ces populations des situations difficiles dans lesquelles ils sont. Les leaders du village ont constitué et animent régulièrement un réseau d’ONG caritatives pour les soutenir. Les habitants concernés par ces aides rendent à la communauté ce qu’elle leur a donné en participant aux travaux collectifs ou en prenant des fonctions de maintenance ou de surveillance des infrastructures et des patrimoines naturels et matériels de la communauté.",
    "La solidarité et l’inclusion sociale restent l’un des soucis constants des leaders du village qui s’assurent que les projets qu’ils proposent à la communauté seront accessibles aux plus pauvres et qu’ils ne génèreront pas de nouveaux déséquilibres ou des risques d’appauvrissement.",
    "La solidarité est active mais de manière plus institutionnalisée. Des associations ou des groupes d’habitants du village s’occupent plus spécifiquement des plus démunis avec l’aide d’ONG partenaires dans des processus clairement définis. Les groupes d’entraide financière des débuts se sont structurés autour de banques communautaires ou ont été remplacées par des agences de micro-crédit qui proposent leurs services. Les membres de la communauté ont de plus en plus le réflexe de « sous traiter » l’aide sociale à des intervenants externes",
    "es effets pervers de l’institutionnalisation de la charité (assistanat des population concernées, recherche constante de donateurs, conflits sur la sélection des bénéficiaires, parfois même malversations financières, ...) ont entrainé des jalousies et des conflits au sens de la communauté. Parfois même la « manne de l’aide » est devenu un enjeu de contrôle politique et financier. La part des dons qui est reversée aux bénéficiaires diminue et la transparence sur l’usage des fonds n’est plus assurée. Les soutiens et les bailleurs/bienfaiteurs se retirent et n’aident plus que très ponctuellement.",
    "C'est pas possible de l'évaluer pour le moment"];



  Future<resp.Response> _createNewResponse() async {
    return responsecontroller.createNewResponse(
      widget.question.questionId.toString(),
      auth.currentUser?.uid ?? "defaultUserId",
      widget.Dowarid!,
    );
  }
  Widget build(BuildContext context) {
    final choicesControllers = <String, ChoicesEditingController>{};
    widget.choicesProvider.enteredChoicesMap.forEach((fieldId, choices) {
      choicesControllers[fieldId] = ChoicesEditingController(initialChoices: choices);
    });
    String fieldId = widget.question.questionId.toString();
    if (choicesControllers[fieldId] == null) {
      widget.choicesProvider.updateChoices(fieldId, ['','']);
    };
    List<String> selectedOptions = choicesControllers[fieldId]?.choices ?? ['', ''];

    return FutureBuilder<resp.Response> (
      future: _createNewResponse(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting && !snapshot.hasError) {
          // If the future completed successfully
          resp.Response rp = snapshot.data!;

          // Use the 'response' object in your widget
          return Padding(
            padding:  EdgeInsets.all(getProportionateScreenHeight(8.0)),
            child: Container(
                padding: EdgeInsets.only( top: getProportionateScreenWidth(20)),
                width: Get.size.width,
                height: getProportionateScreenHeight(390),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
                child :Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.question.questionCorp.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    for (var index= 0; index<options.length; index = index+1 ) ...[
                      Container(
                        // width: getProportionateScreenWidth(450),
                          height: getProportionateScreenHeight(50),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                  width: getProportionateScreenWidth(100),
                                  height: getProportionateScreenHeight(50),
                                  child: ListTile(
                                    title: Text(options[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                    selected: selectedOptions.contains(options[index]),
                                    onTap: () async{

                                      setState(() {
                                        if (options[index] == 'Non évalué') {
                                          // Réponse "Non évalué" : on ne demande pas de deuxième réponse.
                                          selectedOptions[0] = 'Non évalué';
                                          selectedOptions[1] = 'Non évalué';
                                        } else if (selectedOptions[0] == '' || selectedOptions[0] == 'Non évalué') {
                                          selectedOptions[0] = options[index];
                                          selectedOptions[1] = '';
                                        } else if (selectedOptions[1] == '') {
                                          selectedOptions[1] = options[index];
                                        } else {
                                          selectedOptions[0] = selectedOptions[1];
                                          selectedOptions[1] = options[index];
                                        }
                                      });
                                      responsecontroller.UpdateResponse(rp, selectedOptions.toString());
                                      dataSpeceController.saveResponse(rp);
                                      widget.choicesProvider.updateChoices(fieldId, selectedOptions);
                                    },
                                  )),
                              Row(
                                  children:[
                                    SizedBox(
                                      width: getProportionateScreenWidth(200),
                                      child: Text(
                                          ( Descriptions[index].length <= 35)
                                              ? Descriptions[index]
                                              : Descriptions[index].substring(0, 35) + '...',
                                          style: TextStyle(fontSize: 10)
                                      ),
                                    ),
                                    if ( Descriptions[index].length > 35)
                                      TextButton(
                                        child: Text('Voir plus',style: TextStyle(color:Color(0xFF0F8A74),fontSize: 10)),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(options[index],style:TextStyle(color:Color(0xFF0F8A74))),
                                                content: Text(Descriptions[index]),
                                                actions: [
                                                  TextButton(
                                                      child: Text("OK", style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF0F8A74) , fontSize: 11)),
                                                      onPressed: () => Navigator.pop(context))
                                                ],
                                              ));
                                        },

                                      )
                                  ]),
                            ],
                          ))
                    ],
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text('Selected options: ${selectedOptions[0]}, ${selectedOptions[1]}', style: TextStyle(fontWeight: FontWeight.bold , fontSize: 11)),
                  ],
                )),
          );
        }else {
          // Return an empty widget to indicate waiting without any visual indicator
          return Container(); // or SizedBox()
        }
      },
    );
    //final content = TextEditingController(text: textProvider.enteredText);
  }
}
