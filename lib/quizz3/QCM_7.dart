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



class ChooseTwoInOrderQuestion_7 extends StatefulWidget {
  final Question question;
  final String? Dowarid;
  ChoicesProvider choicesProvider;


  ChooseTwoInOrderQuestion_7({
    required this.question,
    required this.Dowarid,
    required this.choicesProvider
  });

  @override
  _ChooseTwoInOrderQuestionState_7 createState() => _ChooseTwoInOrderQuestionState_7();
}

class _ChooseTwoInOrderQuestionState_7 extends State<ChooseTwoInOrderQuestion_7> {
  final IntervalService IS = Get.put(IntervalService());
  final CollectePage CP = Get.put(CollectePage());
  final DowarService DS = Get.put(DowarService());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();
  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  List<String> options = [    'Pré-Émergence',    'Émergence',    'Equilibre',    'Déclin', 'Effondrement', 'Non évalué' ];
  List<String> Descriptions = [
    "Le territoire possède des ressources matérielles (géologie, eau, terres, faune, flore...) et/ou immatérielle (culture distinctive, art, histoire, monuments...) qui ne sont pas forcément connues et valorisées par les habitants et qui constituent un potentiel de création de valeur. Il existe au sein de la communauté des savoirs et des savoir-faire qui permettent de créer de la valeur à partir des ressources locales (agriculture, techniques d’irrigation, artisanat, pastoralisme, bâtiment, cuisine...). Au niveau de la communauté, il existe des structures sociales fonctionnelles coutumières (conseil de tribu) ou modernes (associations, coopératives), qui gèrent quelques aspects du travail collectif autour d’objectifs communs. On trouve aussi parfois des acteurs externes qui ont établi des activités ou des échanges avec des membres de la communauté (commerce, tourisme...)",
    "Au travers d’un processus formel ou informel de dialogue entre les membres de la communauté (parfois avec des catalyseurs extérieurs) un diagnostic partagé des besoins et une évaluation des ressources ont permis d’identifier des projets qu’il est possible de mener localement. Menés par l’ensemble du collectif ou par des entrepreneurs individuels au sein de la communauté, des projets de création de valeur économique sont lancés permettant de valoriser des ressources naturelles et des compétences locales. Des structures de valorisation collectives ont été créées (coopératives, entreprises, ...) qui ont parfois ouverts de toutes nouvelles activités génératrices de revenus. Les membres de la diaspora sont impliqués dans la dynamique et soutiennent certains projets. Dans certains cas, ils créent leurs propres projets et procurent des emplois aux habitants du village.",
    "Bien que toutes ne réussissent pas à se pérenniser, un nombre significatif d’activités créées lors de la phase d’émergence continue à se développer. Les porteurs d’affaires se consacrent à la gestion de leurs activités qui leur procurent des revenus suffisants. L’économie du village s’intègre de plus en plus à des marchés extérieurs pour y commercialiser ses produits. Peu de nouveaux projets voient le jour faute à la fois d’entrepreneurs compétents et motivés et d’opportunités nouvelles. On assiste parfois à l’arrivée d’entrepreneurs étrangers à la communauté qui développent des projets « me-too » pour profiter des ressources et des compétences locales allant même parfois jusqu’à constituer des clusters locaux (notamment dans le domaine de l’artisanat).",
    "Plusieurs facteurs peuvent entrainer le déclin économique d’une communauté rurale : la sur- exploitation des ressources, des conditions naturelles devenues défavorables, la fermeture des débouchés des produits, la difficulté à innover pour s’adapter aux nouveaux besoins, la concurrence interne qui entraîne une baisse progressive (parfois rapide) de la rentabilité, la dépendance de marchés (notamment agricoles) connaissant de très fortes fluctuations de prix ou des réseaux d’intermédiation qui monopolisent la valeur créée, l’insuffisance de la diversification des activités génératrices de revenus, l’attrait de la ville pour des jeunes de plus en plus scolarisés et qui vide le village de ses ressources humaines. Tous ces facteurs, qui parfois se combinent, entraînent une diminution globale de la valeur économique créée, et un appauvrissement progressif",
    "L’appauvrissement de la communauté génère des tensions déclenchant à leur tour des conflits (entrepreneurs et salariés, entrepreneurs concurrents entre eux, autochtones- étrangers, ...) La désagrégation socio- économique et la réduction des opportunités économiques qui en résulte conduit peu à peu les jeunes à aller chercher leurs sources de revenus à l’extérieur de la communauté.",
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
