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



class ChooseTwoInOrderQuestion_2 extends StatefulWidget {
  final Question question;
  final String? Dowarid;
  ChoicesProvider choicesProvider;


  ChooseTwoInOrderQuestion_2({
    required this.question,
    required this.Dowarid,
    required this.choicesProvider
  });

  @override
  _ChooseTwoInOrderQuestionState_2 createState() => _ChooseTwoInOrderQuestionState_2();
}

class _ChooseTwoInOrderQuestionState_2 extends State<ChooseTwoInOrderQuestion_2> {
  final IntervalService IS = Get.put(IntervalService());
  final CollectePage CP = Get.put(CollectePage());
  final DowarService DS = Get.put(DowarService());
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController dataSpeceController = Get.find<DataSpeceController>();
  Responsecontroller responsecontroller = Get.put(Responsecontroller());
  List<String> options = [    'Pré-Émergence',    'Émergence',    'Equilibre',    'Déclin', 'Effondrement', 'Non évalué' ];
  List<String> Descriptions = [
    "La communauté se reconnait comme telle, dans une singularité qu’elle est généralement capable d’articuler (nom, affiliations identitaires, histoire de peuplement, culture et patrimoines, ...). On sent même un sentiment de fierté d’appartenance. Le lien avec la Diaspora reste vivace (retours réguliers des émigrés et transferts financiers pour subvenir aux besoins de leurs familles restées au village). Les valeurs et les ressources culturelles mettent en avant le lien communautaire, la solidarité et l’entraide. Il subsiste des activités (sociales, culturelles, économiques, ...) communes qui contribuent à maintenir et à renforcer les liens sociaux. L’enracinement dans le territoire est affirmé dans les discours et la population connait généralement bien son espace de vie et est capable d’en définir les frontières et les composantes principales. Le souhait de rester « au pays », de ne pas émigrer vers la ville ou à l’étranger est affirmé.",
  "La communauté est reconnue comme modèle de dynamisme et ses caractères spécifiques sont reconnus par ses membres et par ses voisins et ceux qui la visitent.Des projets sont conçus et déployés pour transmettre aux jeunes génération les valeurs et les modes de fonctionnement collectifs de la communauté. De même, de nombreuses initiatives à visées culturelles, sociales ou solidaires contribuent à renforcer la cohésion et à raffermir les liens communautaires. La Diaspora participe aux projets de développement et le leadership communautaire a le souci constant de les intégrer dans la vision collective et dans les réalisations auxquelles les membres « absents » peut les faire contribuer. Dans certains cas, on assiste même au retour de membres de la diaspora qui reviennent s’installer au village. Les Jeunes sont de plus en plus nombreux à envisager leur avenir dans leur village ou en lien étroit avec celui-ci.",
  "La population est fière de ce qu’elle a réussi à faire collectivement et évoque le passé récent où, ensemble, ils ont réussi à transformer leurs conditions de vie dans leur village. Des structures associatives ou traditionnelles se sont peu à peu spécialisée dans la gestion de certaines réalisations ou équipements (terrain de sport, coopératives, ...) ou dans l’animation de certaines catégories de populations (les femmes, les jeunes, ...) Les pratiques de solidarité, toujours effectives, se sont institutionnalisées avec des groupes identifiés (formels ou informels) qui organisent les projets d’entraide, les redistributions et les actions d’urgence. La diaspora continue à financer les actions de solidarité mais plus rarement maintenant de nouveaux projets puisque les grands besoins ont été couverts lors de la phase d’émergence.",
  "Le lien communautaire se désagrège par manque de projet collectif mobilisateur. On ne parle plus de biens communs ou d’intérêt général. L’enthousiasme qui avait rassemblé la communauté lors de la phase d’émergence s’est éteint et l’individualisme ou le recentrage sur l’entourage immédiat (famille, clans, voisinage, ...) s’est installé. Dans les discours, on entend souvent les gens regretter le manque de solidarité. On observe des conflits latents ou ouverts entre des individus, des familles ou même des factions. On note aussi une difficulté à exprimer une différenciation positive de la communauté par rapport à d’autres communautés voisines ou semblables. La communauté se décrit de plus en plus par ses faiblesses (pauvreté, incapacités, ...) que par ses forces ou ses ressources. La résignation réapparait dans les discours ainsi qu’une forme de misérabilisme ou d’auto-dépréciation.",
  "La communauté n’existe plus, du moins plus explicitement pour ses membres. Chacun essaie de s’en sortir comme il peut, indépendamment des autres. La plupart des jeunes veulent quitter le village et les migrations sont relativement nombreuses et fréquentes lorsque des opportunités existent en dehors de la communauté. Ceux qui restent se sentent « piégés ». Pour se tirer d’affaire, chacun survit et en appelle à l’aire de l’Etat, des associations humanitaires, des bienfaiteurs privés, ... La diaspora ne vient plus visiter le village ou alors s’isole en dehors de la communauté.",
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
