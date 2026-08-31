import 'package:cci_app/config.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data_space/controllers/data_space_controller.dart';
import 'package:cci_app/models/Projets_communautaires.dart';
import 'package:cci_app/Projets communautaires/add_project.dart';


class ProjetPage extends StatefulWidget {
  final String? Dowarid;
  ProjetPage({required this.Dowarid});

  @override
  _ProjetPageState createState() => _ProjetPageState();
}

class _ProjetPageState extends State<ProjetPage> {
  late DataSpeceController DS;
  late List<Projet> pjs;


  @override
  List<Widget> addedWidgets = [SizedBox(height: getProportionateScreenHeight(10))];
  void initState() {
    super.initState();
    DS = Get.put(DataSpeceController());
    pjs = DS.projets;
    for(Projet pg in pjs){
      TextEditingController PC = TextEditingController(text: pg.projet);
      TextEditingController DC = TextEditingController(text: pg.descriptif);
      TextEditingController AC = TextEditingController(text: pg.Acteursimp);
      TextEditingController RC = TextEditingController(text: pg.resultat);
      TextEditingController SC = TextEditingController(text: pg.startDate);
      TextEditingController EC = TextEditingController(text: pg.endDate);
      TextEditingController IC = TextEditingController(text: pg.initiateur);
      TextEditingController CC = TextEditingController(text: pg.commentaire);
      String pgid = pg.projetId;
      addedWidgets.add(AddProjetPage(DowarId: widget.Dowarid, isExpanded: false, projetController: PC,descriptifController: DC,ActeursimpController: AC, resultatController: RC,startDateController: SC,endDateController: EC,initiateurController: IC, pgId: pgid, commentaireController: CC,));
      addedWidgets.add(SizedBox(height: getProportionateScreenHeight(10)));
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F8A74),
        title: Text('Projets'),
      ),
      body: ListView(
          children: [
            Column(
        children: [
          ...addedWidgets,
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  addedWidgets.add(AddProjetPage(DowarId: widget.Dowarid, isExpanded: true, projetController: TextEditingController(text: ''),descriptifController: TextEditingController(text: ''),ActeursimpController: TextEditingController(text: ''),resultatController: TextEditingController(text: ''),startDateController: TextEditingController(text: ''),endDateController: TextEditingController(text: ''), initiateurController: TextEditingController(text: ''),commentaireController: TextEditingController(text: ''),));
                  addedWidgets.add(SizedBox(height: getProportionateScreenHeight(10)));

                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF0F8A74), // Set the background color
              ),
              child: Icon(Icons.add),
            ),
          )
           // Spread operator to add the widgets in the list
        ],
      ),])
    );
  }
}
