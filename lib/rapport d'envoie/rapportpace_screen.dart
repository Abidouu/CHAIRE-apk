import 'package:cci_app/collecte/collecte_screen.dart';
import 'package:cci_app/config.dart';
import 'package:cci_app/data_space/controllers/data_space_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:cci_app/rapport d'envoie/components/button_widget.dart";
import 'components/quizz_card.dart';
import 'package:cci_app/data_space/Providers/quizz3_provider.dart';
import 'package:cci_app/data_space/Providers/quizz2_provider.dart';
import 'package:cci_app/data_space/Providers/quizz1_provider.dart';
import 'package:provider/provider.dart';


class RapportSpace extends StatelessWidget {
  final DataSpeceController dataSpeceController = Get.put(DataSpeceController());
  TextProvider textProvider;
  ValueProvider valueProvider;
  ChoicesProvider choicesProvider;




  RapportSpace({super.key, required this.textProvider, required this.choicesProvider,required this.valueProvider});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF0F8A74),
          title: const Text('Données Collectees'),
          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        ),
        body: ListView(

      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        Row(

          children: [
SizedBox(width: getProportionateScreenWidth(10)),
          QuizzCard(
            cardTitle: "Données générales",
            cardDescription: "Vous avez répondu à "+ textProvider.getCount().toString() + " questions",
            onClockFuction: () async {
            },
          ),
         SizedBox(width: getProportionateScreenWidth(15)),
          QuizzCard(
            cardTitle: "Données spécifiques",
            cardDescription: "Vous avez répondu à "+ valueProvider.getCount().toString() + " questions",
            onClockFuction: () async {
            },
          ),
          SizedBox(width: getProportionateScreenWidth(10)),
        ]),
        SizedBox(height: getProportionateScreenHeight(20)),
        Row(
          children: [
              SizedBox(width: getProportionateScreenWidth(10)),
            QuizzCard(
              cardTitle: "Mesure de l’émergence",
              cardDescription: "Vous avez répondu à "+ choicesProvider.getCount().toString() + " questions",
              onClockFuction: () async {
              },
            ),
              SizedBox(width: getProportionateScreenWidth(15)),
            QuizzCard(
              cardTitle: "Ressources locales",
              cardDescription: "Vous avez ajouté "+ dataSpeceController.ressources.length.toString() + " ressources locales",
              onClockFuction: () async {
              },
            ),

          ],
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(10)),
            QuizzCard(
              cardTitle: "Acteurs de l’émergence",
              cardDescription: "Vous avez ajouté "+ dataSpeceController.acteurs.length.toString() + " acteurs de l'émergence" ,
              onClockFuction: () async {
              },
            ),
            SizedBox(width: getProportionateScreenWidth(15)),
            QuizzCard(
              cardTitle: "Infrastructures de base",
              cardDescription: "Vous avez ajouté "+ dataSpeceController.infrastructures.length.toString() + " infrastructures de base",
              onClockFuction: () async {
              },
            ),

          ],
        ),
        SizedBox(height: getProportionateScreenHeight(20)),
        Row(
          children: [
            SizedBox(width: getProportionateScreenWidth(10)),
            QuizzCard(
              cardTitle: "Projets communautaires",
              cardDescription: "Vous avez ajouté "+ dataSpeceController.projets.length.toString() + " projets communautaires",
              onClockFuction: () async {
              },
            ),
            SizedBox(width: getProportionateScreenWidth(15)),
            QuizzCard(
              cardTitle: "Cartographie",
              cardDescription: "la cartographie KUMU ...",
              onClockFuction: () {
              },
            ),

          ],
        ),

         SizedBox(height: getProportionateScreenHeight(10)),
        Row(
          children: [
             SizedBox(width: getProportionateScreenWidth(10)),
          ButtonWidget(buttonLable: dataSpeceController.medias.length.toString()+" Medias", buttonOnClickFunction: () {}),
        ]),
        SizedBox(height: getProportionateScreenHeight(30)),
        Center(
          child: ButtonSentWidget(
            buttonLable: "Envoyer",
            buttonOnClickFunction: () async{
              await dataSpeceController.saveDataToFirebase();
              await dataSpeceController.deleteCash();
              textProvider.clearAllInstances();
              valueProvider.clearAllInstances();
              choicesProvider.clearAllInstances();
              Get.to(() => CollectePage());

            },
          ),
        )
      ],
    ));
  }
}

