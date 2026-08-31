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



class ChooseTwoInOrderQuestion_6 extends StatefulWidget {
  final Question question;
  final String? Dowarid;
  ChoicesProvider choicesProvider;


  ChooseTwoInOrderQuestion_6({
    required this.question,
    required this.Dowarid,
    required this.choicesProvider
  });

  @override
  _ChooseTwoInOrderQuestionState_6 createState() => _ChooseTwoInOrderQuestionState_6();
}

class _ChooseTwoInOrderQuestionState_6 extends State<ChooseTwoInOrderQuestion_6> {
  final IntervalService IS = Get.put(IntervalService());
  final CollectePage CP = Get.put(CollectePage());
  final DowarService DS = Get.put(DowarService());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();
  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  List<String> options = [    'Pré-Émergence',    'Émergence',    'Equilibre',    'Déclin', 'Effondrement', 'Non évalué'];
  List<String> Descriptions = [
    "Les leaders de la communauté reconnaissent l’importance de l’éducation et cherchent des moyens d’améliorer les résultats et de convaincre les parents de s’investir plus dans la scolarité de leurs enfants. Certains parents réfléchissent ou ont même déjà initié la création d’une association des parents dans le but d’améliorer les choses. Parfois, pour certains, il s’agit de trouver un moyen de transmettre aux enfants les savoir-faire vernaculaires qui permettront aux jeunes générations de pouvoir mener une existence décente dans la communauté. Les jeunes, lorsqu’on les interroge, veulent souvent poursuivre leurs études mais comprennent mal le système scolaire et comment s’y orienter. Ils n’ont souvent qu’une idée très vague des carrières qu’ils pourraient/voudraient poursuivre.",
    "La communauté s’attaque avec succès (souvent avec des ONG partenaires ou en réclamant directement auprès des services de l’Etat concernés) aux différentes problématiques liées à la scolarisation (équipements, achat des livres et des fournitures, transport, internats, bourses, ...). Les parents d’élèves s’intéressent de plus en plus à leurs enfants en participant à la vie scolaire. Les résultats s’améliorent et un nombre croissant de jeunes de la communauté accède à l’université. Ceux qui le souhaitent trouvent des opportunités d’emploi salarié dans l’industrie ou les services. Ceux qui ne réussissent pas à l’école ou qui ne souhaitent pas quitter leur village trouvent sur place des formations pour acquérir des compétences utiles et valorisées dans l’économie communautaire, leur permettant ainsi d’avoir des revenus et une vie décente.",
    "Le système éducatif dans toutes ses composantes fonctionne à la satisfaction des habitants. Les jeunes reconnaissent qu’ils ont plusieurs voies qui leurs permettent d’accéder à différentes carrières ou choix de vie. Les différentes composantes du système (transmission locale, formation des jeunes adultes, préscolaire, école primaire et secondaire, associations des parents d’élèves, ...) se spécialisent et sont ainsi plus performants.",
    "Par manque de résultats en termes d’employabilité ou à la suite de mauvais choix politiques ou opérationnels, le système éducatif local se désagrège et l’ensemble des participants perd peu à peu confiance dans sa capacité à fournir aux jeunes les moyens de leur future subsistance et d’une existence digne. Les jeunes perdent espoir et motivation, les parents se désintéressent et les leaders n’ont plus d’idées ou de capacité à mobiliser l’ensemble de la communauté autour des enjeux d’éducation et de transmission.",
    "Les résultats scolaires sont très faibles. Peu d’enfants vont au lycée et encore moins font des études supérieures. Les filles dépassent rarement le niveau du collège ne restant dans le système éducatif que tant que celui-ci est obligatoire. Les parents ne voient pas l’intérêt de l’école et se désintéressent des résultats de leurs enfants. On attend que la « solution » vienne de l’extérieur, de l’Etat ou d’ONG. De plus en plus de jeunes quittent de manière prématurée le système éducatif et vont chercher des emplois non qualifiés à l’extérieur du village.",
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
