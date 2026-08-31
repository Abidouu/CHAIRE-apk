import 'package:cci_app/config.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data_space/controllers/data_space_controller.dart';
import 'package:cci_app/infrastructures_de_base/add_infrastructure.dart';
import 'package:cci_app/models/infrastructures_de_base.dart';


class InfrastructurePage extends StatefulWidget {
  final String? Dowarid;
  InfrastructurePage({required this.Dowarid});

  @override
  _InfrastructurePageState createState() => _InfrastructurePageState();
}

class _InfrastructurePageState extends State<InfrastructurePage> {
  late DataSpeceController DS;
  late List<Infrastructure> infs;

  @override
  List<Widget> addedWidgets = [SizedBox(height: getProportionateScreenHeight(10))];
  void initState() {
    super.initState();
    DS = Get.put(DataSpeceController());
    infs = DS.infrastructures;
    for(Infrastructure inf in infs){
      TextEditingController IC = TextEditingController(text: inf.infrastructure);
      TextEditingController DC = TextEditingController(text: inf.Disponible);
      TextEditingController QC = TextEditingController(text: inf.qualite_percue);
      TextEditingController SC = TextEditingController(text: inf.Suffisant);
      TextEditingController EC = TextEditingController(text: inf.etat);
      TextEditingController EcC = TextEditingController(text: inf.encours);
      TextEditingController DiC = TextEditingController(text: inf.distance);
      TextEditingController CoC = TextEditingController(text: inf.commentaire);
      TextEditingController RgC = TextEditingController(text: inf.generationRevenus);
      TextEditingController StC = TextEditingController(text: inf.statut);
      TextEditingController PrC = TextEditingController(text: inf.priorite);
      TextEditingController EtC = TextEditingController(text: inf.etudeTechnique);
      TextEditingController BgC = TextEditingController(text: inf.budget);
      TextEditingController FiC = TextEditingController(text: inf.financement);
      TextEditingController DlC = TextEditingController(text: inf.dateLancement);
      TextEditingController DfC = TextEditingController(text: inf.dateFin);
      TextEditingController FmC = TextEditingController(text: inf.financementMateriel);
      TextEditingController FoC = TextEditingController(text: inf.financementMainOeuvre);

      String infid = inf.infrastructureId;
      addedWidgets.add(AddInfrastructurePage(
        DowarId: widget.Dowarid,
        isExpanded: false,
        infrastructureController: IC,
        disponibleController: DC,
        qualite_percueController: QC,
        suffisantController: SC,
        etatController: EC,
        encoursController: EcC,
        distanceController: DiC,
        infId: infid,
        commentaireController: CoC,
        revenusController: RgC,
        statutController: StC,
        prioriteController: PrC,
        etudeTechniqueController: EtC,
        budgetController: BgC,
        financementController: FiC,
        dateLancementController: DlC,
        dateFinController: DfC,
        financementMaterielController: FmC,
        financementMainOeuvreController: FoC,
      ));
      addedWidgets.add(SizedBox(height: getProportionateScreenHeight(10)));
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F8A74),
        title: Text('Infrastructures'),
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
                  addedWidgets.add(AddInfrastructurePage(
                    DowarId: widget.Dowarid,
                    isExpanded: true,
                    infrastructureController: TextEditingController(text: ''),
                    qualite_percueController: TextEditingController(text: ''),
                    // Quantité par défaut à 1 : la sélection du type implique déjà
                    // l'existence d'au moins une unité (point 3 de l'e-mail d'Ahmed).
                    disponibleController: TextEditingController(text: '1'),
                    suffisantController: TextEditingController(text: ''),
                    etatController: TextEditingController(text: ''),
                    encoursController: TextEditingController(text: ''),
                    distanceController: TextEditingController(text: ''),
                    commentaireController: TextEditingController(text: ''),
                    revenusController: TextEditingController(text: ''),
                    statutController: TextEditingController(text: ''),
                    prioriteController: TextEditingController(text: ''),
                    etudeTechniqueController: TextEditingController(text: ''),
                    budgetController: TextEditingController(text: ''),
                    financementController: TextEditingController(text: ''),
                    dateLancementController: TextEditingController(text: ''),
                    dateFinController: TextEditingController(text: ''),
                    financementMaterielController: TextEditingController(text: ''),
                    financementMainOeuvreController: TextEditingController(text: ''),
                  ));
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
