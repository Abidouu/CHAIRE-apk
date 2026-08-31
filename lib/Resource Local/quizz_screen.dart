import 'package:cci_app/config.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data_space/controllers/data_space_controller.dart';
import 'package:cci_app/Resource Local/add_ressource.dart';
import 'package:cci_app/models/Ressource_local.dart';


class ResourcePage extends StatefulWidget {
  final String? Dowarid;
  ResourcePage({required this.Dowarid});

  @override
  _ResourcePageState createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  late DataSpeceController DS;
  late List<Resource> ress;

  // Define the text editing controllers outside initState
  List<TextEditingController> controllers = [];

  @override
  List<Widget> addedWidgets = [SizedBox(height: getProportionateScreenHeight(10))];
  void initState() {
    super.initState();
    DS = Get.put(DataSpeceController());
    ress = DS.ressources;

    // Populate the controllers list
    for (Resource rs in ress) {
      TextEditingController RC = TextEditingController(text: rs.ressource);
      TextEditingController DC = TextEditingController(text: rs.descriptif);
      TextEditingController NC = TextEditingController(text: rs.nbreCitations);
      TextEditingController PC = TextEditingController(text: rs.projetsExploitent);
      TextEditingController CC = TextEditingController(text: rs.CommunautaireORindividuelle);
      TextEditingController CoC = TextEditingController(text: rs.commentaire);
      String resid = rs.ressourceId;

      controllers.addAll([RC, DC, NC, PC, CC, CoC]);

      addedWidgets.add(
        AddResourcePage(
          DowarId: widget.Dowarid,
          isExpanded: false,
          ressourceController: RC,
          projetsExploitentController: PC,
          communautaireOrIndividuelleController: CC,
          nbreCitationsController: NC,
          descriptifController: DC,
          resId: resid,
          commentaireController: CoC,)
    );
      addedWidgets.add(SizedBox(height: getProportionateScreenHeight(10)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0F8A74),
        title: Text('Ressources locales'),
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
                      addedWidgets.add(
                        AddResourcePage(
                          DowarId: widget.Dowarid,
                          isExpanded: true,
                          ressourceController: TextEditingController(text: ''),
                          projetsExploitentController: TextEditingController(text: ''),
                          communautaireOrIndividuelleController: TextEditingController(text: ''),
                          nbreCitationsController: TextEditingController(text: ''),
                          descriptifController: TextEditingController(text: ''),
                          commentaireController: TextEditingController(text: ''),
                        ),
                      );
                      addedWidgets.add(SizedBox(height: getProportionateScreenHeight(10)));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF0F8A74), // Set the background color
                  ),
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
