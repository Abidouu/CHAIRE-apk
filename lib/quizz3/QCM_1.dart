import 'package:cci_app/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cci_app/models/question.dart';
import 'package:cci_app/data_space/Providers/quizz3_provider.dart';
import 'package:cci_app/data_space/controllers/choices_Edditing_Controller.dart';
import 'package:cci_app/data_space/controllers/resonse_controller.dart';
import 'package:cci_app/models/responce.dart' as resp;
import 'package:cci_app/data_space/controllers/data_space_controller.dart';
import 'package:cci_app/services/loc_service.dart';
import 'package:cci_app/services/dowar_services.dart';
import 'package:cci_app/collecte/collecte_screen.dart';



class ChooseTwoInOrderQuestion_1 extends StatefulWidget {
  final Question question;
  final String? Dowarid;
  ChoicesProvider choicesProvider;


  ChooseTwoInOrderQuestion_1({
    required this.question,
    required this.Dowarid,
    required this.choicesProvider
  });

  @override
  _ChooseTwoInOrderQuestionState_1 createState() => _ChooseTwoInOrderQuestionState_1();
}

class _ChooseTwoInOrderQuestionState_1 extends State<ChooseTwoInOrderQuestion_1> {
  final IntervalService IS = Get.put(IntervalService());
  final CollectePage CP = Get.put(CollectePage());
  final DowarService DS = Get.put(DowarService());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();
  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  List<String> options = [    'Pré-Émergence',    'Émergence',    'Equilibre',    'Déclin', 'Effondrement', 'Non évalué'];
  List<String> Descriptions = [
    "La communauté se trouve dans un environnement géographiquement isolé des centres d’activité et de décisions. Dans certains cas, elle a choisi de s’isoler des flux de passage autour d’un centre urbain ou semi-urbain proche dans un souci de préservation identitaire ou de son cadre de vie ou de ses pratiques culturelles.Dans les zones isolées par la géographie, il existe des possibilités, et parfois même des projets de désenclavement (routes, transports en commun, ...). Dans les communautés isolées, par choix ou par la géographie, des ressources locales exploitables pour s’autonomiser existent et la population maitrise les compétences de base permettant d’en tirer profit. Le village dispose ou est en voie de disposer des infrastructures de base nécessaires à l’existence et au développement de futurs projets.",
  "Sous l’impulsion des leaders et avec l’aide de partenaires extérieurs, les infrastructures manquantes (routes, scolaire, santé, réseaux, ...) sont peu à peu mises en place soit par les services de l’Etat soit par la communauté elle-même. Plusieurs projets d’autonomisation fondés sur l’exploitation des ressources naturelles locales afin de répondre aux besoins de la population sont mis en œuvre et permettent de développer ou de relocaliser des activités vivrières ou génératrices de revenus au sein de la communauté. Les projets de valorisation des richesses naturelles prennent parfois en compte le renouvellement et la durabilité des ressources consommées.",
  "Les voies d’accès existent et permettent quotidiennement l’accès facile de la communauté à l’ensemble des services publics et privés dont ses membres pourraient avoir besoin (éducation, santé, emplois distants, marchés d’approvisionnement, ...). Les moyens de transport sont disponibles en nombre suffisant et la fréquence des rotations répond aux besoins courants ou urgents.Peu d’infrastructures nouvelles sont mises en place (tous les besoins sont couverts) mais celles qui existent sont maintenues, financées, de bonne qualité et restent en bon état de fonctionnement.Un marché local s’est développé qui donne accès à tout un chacun aux biens et aux services produits à l’intérieur de la communauté.",
  "L’exploitation non maîtrisée des ressources locales s’est traduite par la raréfaction de ces ressources et des conflits de propriété ou d’usage ont parfois même éclaté. Les infrastructures qui avaient été mises en place sont obsolètes, insuffisantes pour couvrir les (nouveaux) besoins. Elles ont parfois même été abandonnées faute de maintenance, de travail collectif pour les entretenir, de formation pour les exploiter, ou de financement. Dans certains cas, l’usage de ces infrastructures donne lieu à des conflits et la communauté préfère s’en désengager.",
  "L’isolement de la communauté est perçu comme une barrière au développement. Les services de l’Etat sont perçus comme lointains et ne semblent pas s’intéresser au développement du village. Ces communautés isolées connaissent mal ou pas du tout les ressources locales exploitables pour s’autonomiser et la population ne maitrise plus les compétences de base permettant d’en tirer profit. Les infrastructures de base sont très réduites et ne peuvent pas servir d’appui à de de futurs projets de développement.",
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
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(widget.question.questionCorp.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    for (var index= 0; index<options.length; index = index+1 ) ...[
                      Container(
                          //width: getProportionateScreenWidth(450),
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
