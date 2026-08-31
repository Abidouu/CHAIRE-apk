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



class ChooseTwoInOrderQuestion_3 extends StatefulWidget {
  final Question question;
  final String? Dowarid;
  ChoicesProvider choicesProvider;


  ChooseTwoInOrderQuestion_3({
    required this.question,
    required this.Dowarid,
    required this.choicesProvider
  });

  @override
  _ChooseTwoInOrderQuestionState_3 createState() => _ChooseTwoInOrderQuestionState_3();
}

class _ChooseTwoInOrderQuestionState_3 extends State<ChooseTwoInOrderQuestion_3> {
  final IntervalService IS = Get.put(IntervalService());
  final CollectePage CP = Get.put(CollectePage());
  final DowarService DS = Get.put(DowarService());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();
  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  List<String> options = [    'Pré-Émergence',    'Émergence',    'Equilibre',    'Déclin', 'Effondrement', 'Non évalué' ];
  List<String> Descriptions = [
    "Un individu ou une petite équipe exprime le désir de changement et travaille à mobiliser les énergies, propose des transformations et œuvre à la réalisation des projets. Ce premier groupe est conscient que le projet collectif mettra plusieurs années à se concrétiser mais articule une vision d’avenir dans lequel le reste de la communauté se reconnait. Ce groupe de départ n’est pas toujours très organisé et doit dans certains cas composer avec les structures de pouvoir traditionnelles ou politiques. Un catalyseur extérieur (plus rarement plusieurs à ce stade), c’est-à-dire une ressource extérieure à la communauté mais concernée par son développement et son bien-être futur, est déjà clairement identifié ou commence à apparaître. Parfois, les catalyseurs et les leaders travaillent en étroite collaboration voire osmose pour démarrer de petits projets mobilisateurs et à impacts visibles afin de démarrer la dynamique collective.",
    "Sous l’impulsion du nouveau leadership, la communauté s’est fixé une feuille de route ou des objectifs de résultats qui sont la matérialisation de la vision commune en germe lors de la phase de pré- émergence. Les décisions sont prises collégialement et la population participe aux débats. Les autres formes de gouvernance (traditionnelle, politique, ...) sont associées et travaillent ensemble. Le leadership est fortement investi dans la réussite des projets. Ceux qui en font partie ont des rôles identifiés. Les leaders rendent compte régulièrement à la population des résultats de leurs actions, des objectifs poursuivis et des moyens mobilisés. Au fur et à mesure des projets mis en œuvre, d’autres structures de gouvernance ou de leadership apparaissent (associations féminines, jeunes, coopératives, ...) créant un besoin pour de nouveaux leaders",
    "Le leadership communautaire ne lance plus ou presque plus de grands projets car les besoins critiques sont comblés. On passe d’une logique de développement, d’innovations sociales et d’investissements pour le futur à une logique de « bonne gestion ». Le leadership initial se désengage peu à peu et passe la main à une nouvelle génération de leaders qui ont été identifiés lors de la phase précédente. Ces leaders gèrent les réalisations faites et entretiennent les réseaux de soutien qu’avaient su mobiliser leurs prédécesseurs notamment au travers de plus petits projets ou d’appels ponctuels à des dons. Les leaders initiaux ont maintenant du mal à exprimer un nouveau projet collectif pour le futur. Lorsqu’ils (où ceux qui les remplaceront) y parviennent malgré tout, la communauté pourra peut- être redémarrer un nouveau cycle d’émergence. Dans le cas contraire, ce sera sans doute le début du déclin. ",
    "Par rapport à d’autres communautés comparables, la communauté prend peu à peu du retard sur les indicateurs socio-économiques. Plus aucun projet collectif n’est entrepris et lorsqu’un projet est malgré tout lancé, les conditions de mise en œuvre (réponse au besoin, qualité et délai de réalisation, engagement de la population, ...) sont généralement mauvaises. Le leadership est de plus en plus absent. Les bureaux des associations ne se réunissent plus régulièrement ; certains collectifs, associations ou coopératives ont même cessé leurs activités sans être remplacés.",
    "Plus aucun projet collectif n’est entrepris et le leadership est absent. . Les bureaux des associations ne se réunissent plus régulièrement. Les collectifs économiques, culturels ou sociaux sont essentiellement des coquilles vides dont la seule activité se résume souvent à la recherche de subventions et de fonds de bienfaiteurs. Les positions de Leadership ne sont plus recherchées et lorsqu’elles le sont, cela peut donner lieu à des conflits de pouvoir, d’influence ou d’intérêts entre différentes factions ou individus. La communauté fait appel à l’Etat ou aux représentants politiques pour résoudre ses problèmes.",
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
