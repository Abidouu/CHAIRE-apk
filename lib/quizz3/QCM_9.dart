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



class ChooseTwoInOrderQuestion_9 extends StatefulWidget {
  final Question question;
  final String? Dowarid;
  ChoicesProvider choicesProvider;


  ChooseTwoInOrderQuestion_9({
    required this.question,
    required this.Dowarid,
    required this.choicesProvider
  });

  @override
  _ChooseTwoInOrderQuestionState_9 createState() => _ChooseTwoInOrderQuestionState_9();
}

class _ChooseTwoInOrderQuestionState_9 extends State<ChooseTwoInOrderQuestion_9> {
  final IntervalService IS = Get.put(IntervalService());
  final CollectePage CP = Get.put(CollectePage());
  final DowarService DS = Get.put(DowarService());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();
  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  List<String> options = [    'Pré-Émergence',    'Émergence',    'Equilibre',    'Déclin', 'Effondrement', 'Non évalué'];
  List<String> Descriptions = [
    "La communauté est dans une attitude d’ouverture vis-à-vis de l’extérieur. Parfois cette attitude d’ouverture ne se manifeste que chez les leaders du village. De temps à autres, des ONG viennent faire quelques actions et sont généralement bien reçues. Elles sont prêtes à revenir mener des projets Parfois, quelques marcheurs ou touristes viennent passer une nuit au village lorsque celui-ci dispose d’un gite ou que l’on peut y loger chez l’habitant. Les habitants qui migrent temporairement ou de manière saisonnière pour trouver du travail sont les seuls à être vraiment soumis à une influence extérieure qu’ils intègrent parfois dans leurs modes de vie ou dans leurs pratiques sociales de retour au village. La diaspora a gardé des contacts dans le village et revient y séjourner. Un catalyseur extérieur est clairement identifié ou commence à émerger.",
  "Reconnaissant l’importance d’un bon réseau de partenaires et de soutiens externes, la communauté s’ouvre volontairement en recevant des visiteurs et en allant visiter d’autres lieux pour y acquérir de nouvelles compétences ou pour y trouver de nouvelles idées. Les partenariats de plus en plus nombreux avec des ONG, des bailleurs, ou d’autres communautés sont aussi l’occasion de rencontrer une grande diversité d’interlocuteurs. Parfois le village a même adhéré à un réseau plus large où s’échangent idées et bonnes pratiques. La diaspora est très active, s’impliquant dans les projets du village et leurs contributions sont accueillies positivement par les habitants.",
  "Les réseaux ne s’étendent plus mais continuent à fonctionner et à échanger régulièrement avec les membres de la communauté. Les partenaires et les soutiens répondent toujours présents lorsqu’on les sollicite,. L’accueil des visiteurs extérieurs est maintenant organisé et institutionnalisé. Souvent, ce accueil se fait dans un cadre purement touristique. Avec des taux de réussite plus élevés à l’école, les jeunes quittent le village sur de longues périodes pour poursuivre des études secondaires et supérieures. Dans les établissements scolaires, dans les villes universitaires, ils rencontrent d’autres jeunes et découvrent d’autres manières de penser, d’envisager l’avenir. Eux aussi tissent un réseau de relations qui pourra servir la communauté.",
  "Les réseaux se délient peu à peu du fait du manque de nouveaux projets communs. Les soutiens historiques partent eux aussi pour les mêmes raisons. Les voyageurs, les touristes, les migrants temporaires et les membres de la diaspora sont de moins en moins écoutés.",
  "Le village se retrouve de plus en plus isolé et ne parvient pas à générer de nouveaux interlocuteurs ou de nouveaux partenaires. Les jeunes se détournent du village parce qu’il n’intéresse plus personne ou au contraire s’y enferment accentuant encore plus leur isolement. Les membres de la diaspora se désintéressent du village et de ses problématiques par manque d’interlocuteurs internes et de partenaires sérieux. Les ONG qui ne sont plus du tout sollicitées par les leaders du village, ne viennent plus proposer leurs services.",
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
