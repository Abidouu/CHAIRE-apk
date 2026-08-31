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



class ChooseTwoInOrderQuestion_4 extends StatefulWidget {
  final Question question;
  final String? Dowarid;
  ChoicesProvider choicesProvider;


  ChooseTwoInOrderQuestion_4({
    required this.question,
    required this.Dowarid,
    required this.choicesProvider
  });
  @override
  _ChooseTwoInOrderQuestionState_4 createState() => _ChooseTwoInOrderQuestionState_4();
}

class _ChooseTwoInOrderQuestionState_4 extends State<ChooseTwoInOrderQuestion_4> {
  final IntervalService IS = Get.put(IntervalService());
  final CollectePage CP = Get.put(CollectePage());
  final DowarService DS = Get.put(DowarService());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();
  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  List<String> options = [    'Pré-Émergence',    'Émergence',    'Equilibre',    'Déclin', 'Effondrement', 'Non évalué'];
  List<String> Descriptions = [
    "L’existence d’une identité culturelle fondée sur la langue, l’ethnie, les valeurs, les pratiques sociales, les arts et les techniques, l’histoire ancienne et récente, est avérée au sein du groupe qui y reconnait une source importante du lien entre les membres de la communauté et de ce qui fonde leur unité et leur spécificité. La communauté reconnait qu’elle dispose d’un fonds patrimonial (naturel, culturel, matériel et/ou immatériel) et qu’elle doit à la fois le préserver, le transmettre et l’exploiter.",
    "Les leaders comprennent bien les enjeux de préservation/transmission/ valorisation des patrimoines naturels et culturels de leur communauté. Plusieurs projets de préservation/ transmission/valorisation des patrimoines ont été engagés ou sont prévus dans la « feuille de route » de la communauté. Ces projets peuvent être liés à la préservation architecturale, la relance de certaines activités traditionnelles (artisanat, fêtes locales, ...), le développement de nouvelles activités exploitant les richesses culturelles (festivals, tourisme, ...), l’éducation des enfants et des plus jeunes à des pratiques, des savoir-faire ou des valeurs partagées par le groupe, ... Toutes ces activités peuvent être entreprises dans le cadre du collectif communautaire ou par des individus qui sont soutenus par la communauté et par ses leaders. Parfois des partenaires externes s’investissent dans les projets culturels de la communauté.",
    "Les différentes activités culturelles et celles liées aux patrimoines fonctionnent dans des cadres institutionnalisés au sein de la communauté (école communautaire, centres culturels, activités touristiques, festivals, activités de valorisation des produits du terroir et des autres ressources naturelles, ...). Des groupes indépendants tendent peu à peu à prendre le leadership sur chacune de ces activités (association culturelle des habitants, association des jeunes, coopératives, entrepreneurs locaux, ...). Le souci de préserver ces richesses patrimoniales reste important et partagé par le plus grand nombre afin d’éviter la surexploitation ou la disparition par manque d’intérêt des habitants.",
    "La surexploitation culturelle, le faible potentiel économique ou encore la domination de plus en plus prégnante d’un autre modèle culturel (notamment citadin et/ou globalisé) entraîne une perte d’intérêt pour les patrimoines et pour les productions qui s’y rattachent. Les ressources naturelles, les savoir-faire, les patrimoines matériels, les pratiques sociales, les arts et les techniques qui faisaient autrefois la richesse de la communauté et participaient de son « art de vivre » autant que de ses moyens de subsistance disparaissent peu à peu sans être réellement remplacés. Les nouvelles pratiques culturelles ont un très faible ancrage local et ne sont pas reconnues comme étant spécifiques à la communauté et à son identité.",
    "Rares ou inexistants sont les membres de la communauté qui sont préoccupés par ou engagés dans la préservation / transmission / valorisation patrimoniale. Les jeunes se détournent de ce qui faisaient la fierté des anciens et tournent leur regard vers d’autres références culturelles qui ne sont pas toujours adaptées à leur contexte territorial. Lorsqu’on les interroge, ils ont du mal à identifier les éléments positifs de leur culture local et ont tendance à se projeter dans une « autre » vie, « ailleurs ». Il n’y a plus aucun de projet de valorisation des patrimoines.",
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
