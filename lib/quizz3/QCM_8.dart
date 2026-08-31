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



class ChooseTwoInOrderQuestion_8 extends StatefulWidget {
  final Question question;
  final String? Dowarid;
  ChoicesProvider choicesProvider;


  ChooseTwoInOrderQuestion_8({
    required this.question,
    required this.Dowarid,
    required this.choicesProvider
  });

  @override
  _ChooseTwoInOrderQuestionState_8 createState() => _ChooseTwoInOrderQuestionState_8();
}

class _ChooseTwoInOrderQuestionState_8 extends State<ChooseTwoInOrderQuestion_8> {
  final IntervalService IS = Get.put(IntervalService());
  final CollectePage CP = Get.put(CollectePage());
  final DowarService DS = Get.put(DowarService());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();
  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  List<String> options = [    'Pré-Émergence',    'Émergence',    'Equilibre',    'Déclin', 'Effondrement', 'Non évalué'];
  List<String> Descriptions = [
    "Les leaders de la communauté (ou tout au moins ceux qui semblent l’être aux yeux de la population) sont convaincus de la nécessité d’apporter des changements importants et de « faire les choses différemment ». Ils écoutent les idées apportées par l’extérieur et s’intéressent à ce que d’autres communautés qui leur ressemblent ont fait pour améliorer leurs conditions de vie. Ils reconnaissent que des innovations sont à la fois souhaitables et possibles chez eux. Quelquesprojets novateurs ont d’ailleurs été mis en place ou sont en phase avancée de réflexion. Parfois un catalyseur extérieur (individu ou association) a initié un travail de réflexion avec les leaders du village sur ce qui devrait changer en termes de pratiques, sur les choses nouvelles à mettre en place, sur les opportunités qui restent à saisir.",
    "L’esprit d’innovation s’étend peu à peu à l’ensemble de la population et notamment aux jeunes. Des activités et des techniques nouvelles se développent dans des produits, des métiers ou secteurs qui étaient peu explorés. Les pratiques (agricoles, artisanales, sociales, culturelles, ...) changent sous l’impulsion des habitants du village et non pas simplement sous l’influence de l’extérieur. Les innovations peuvent être aussi sociales avec une transformation des modalités de gouvernance, un changement du regard sur les femmes et les jeunes, la création d’espaces nouveaux de dialogues, d’apprentissage et de transmission, de création de valeur, ou la modification des représentations collectives.",
    "L’innovation est encouragée à tous les niveaux (enfants, jeunes, adultes, individus et organisations, ...) et dans tous les domaines (sociaux, économiques, culturels, ...). On voit de nombreuses réalisations et les habitants expriment leur fierté d’avoir fait quelque chose « qui ne se faisait pas avant ». Les jeunes reviennent s’installer avec des projets et des idées novatrices qu’ils arrivent à mettre en œuvre en rencontrant peu de résistance. D’autres communautés viennent visiter le village pour s’inspirer des pratiques innovantes qui y sont déployées.",
    "Un rythme de changement trop rapide pour certains membres de la communauté commence à générer des résistances de ceux qui pensent que tout cela va trop vite ou qui réalisent que les innovations ont surtout profité à d’autres. Parfois le déclin vient tout simplement du fait que les problèmes complexes nécessitant des transformations et la mobilisation d’innovations ont été réglés dans les phases précédentes .",
    "Le rythme devenu très lent des changements, le faible succès ou parfois même l’échec des dernières innovations mises en œuvre ont généré un désintérêt voire même parfois une franche résistance à l’introduction de nouvelles innovations. La communauté se replie sur la tradition ou sur des pratiques figées, même si celles-ci ne permettent pas de répondre aux défis qu’elle doit affronter. Plus personne ne recherche de nouvelles idées.",
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
