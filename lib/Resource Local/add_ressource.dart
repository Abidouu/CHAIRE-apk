import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cci_app/data_space/controllers/data_space_controller.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:cci_app/models/Ressource_local.dart';
import 'package:cci_app/services/type_list_service.dart';
import 'package:cci_app/config.dart';
import 'package:cci_app/Resource Local/picker.dart';
import 'package:intl/intl.dart';

class AddResourcePage extends StatefulWidget {
  final String? DowarId;
  final String? resId;
  bool isExpanded;
  TextEditingController ressourceController = TextEditingController();
  TextEditingController descriptifController = TextEditingController();
  TextEditingController communautaireOrIndividuelleController =
  TextEditingController();
  TextEditingController nbreCitationsController = TextEditingController();
  TextEditingController projetsExploitentController = TextEditingController();
  TextEditingController commentaireController = TextEditingController();

  AddResourcePage({
    required this.DowarId,
    required this.isExpanded,
    required this.ressourceController,
    required this.projetsExploitentController,
    required this.communautaireOrIndividuelleController,
    required this.nbreCitationsController,
    required this.descriptifController,
    required this.commentaireController,
    this.resId
  });

  @override
  _AddResourcePageState createState() => _AddResourcePageState();
}

class _AddResourcePageState extends State<AddResourcePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController DS = Get.put(DataSpeceController());
  final TypeListService typeListService = TypeListService();
  final List<String> infrastructureList = ['Electricité', 'Eau pour irrigation', 'Eau potable', 'Eau courante dans les foyers','Réseau GSM','Réseau Internet','Préscolaire','Ecole primaire','Collège','Lycée','Formations techniques','Internat','Route d’accès','Dispensaire/infirmerie','Hôpital','Centre maternel','Pharmacie','Ambulance','Dar Talib','Dar Chabab','Dar Attakafa','Souk hebdomadaire','Sports et jeunesse','Mosquée','Autre : '];
  // Liste par défaut, remplacée par le contenu de Firestore
  // ('type_lists/ressources_proprietaire') si l'admin en a défini un (point 1).
  List<String> prList= ['Individu du douar','Individu externe','Village / Douar (collectif)','Communauté locale','Tribu', 'Cooperative locale', 'Entreprise externe', 'État', 'Autre'];
  final List<String> ctList=['1 seule personne','2 personnes','3 ou 4 personnes','plus de 5 personnes'];

  // Define variables for the form fields


  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    typeListService.getValues('ressources_proprietaire', prList).then((values) {
      if (mounted) {
        setState(() {
          prList = values;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.isExpanded = !widget.isExpanded;
              isEditing = true;

              widget.ressourceController.text = widget.ressourceController.text;
              widget.descriptifController.text = widget.descriptifController.text;
              widget.communautaireOrIndividuelleController.text =
                  widget.communautaireOrIndividuelleController.text;
              widget.nbreCitationsController.text = widget.nbreCitationsController.text;
              widget.projetsExploitentController.text =
                  widget.projetsExploitentController.text;
              widget.commentaireController.text =widget.commentaireController.text;

            });
          },
          child: AnimatedContainer(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(30),right:getProportionateScreenWidth(30)),
            duration: Duration(milliseconds: 300),
            width: getProportionateScreenWidth(400),
            height: widget.isExpanded ? getProportionateScreenHeight(560) : getProportionateScreenHeight(70),
            decoration: BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isExpanded)
                  Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(10)),
                      Text(
                        "Ajouter une ressource local",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(12)),
                      TextField(
                        controller: widget.ressourceController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white, // replace with desired color
                          hintText: 'Resource ...',
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        controller: widget.descriptifController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Description ...',
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        controller: widget.communautaireOrIndividuelleController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Propriété ...',
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return MyPickerWidget(
                                options: prList,
                                onItemSelected: (selectedValue) {
                                  if (selectedValue != null) {
                                    setState(() {
                                      widget.communautaireOrIndividuelleController.text = selectedValue;
                                    });
                                  }
                                },
                                onSuggestNew: (newType) {
                                  typeListService.suggestType(
                                    'ressources_proprietaire',
                                    newType,
                                    auth.currentUser?.uid ?? "defaultUserId",
                                    dowarId: widget.DowarId,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        controller: widget.nbreCitationsController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Cité spontanément par...',
                        ),
                        keyboardType: TextInputType.number,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return MyPickerWidget(
                                options: ctList,
                                onItemSelected: (selectedValue) {
                                  if (selectedValue != null) {
                                    setState(() {
                                      widget.nbreCitationsController.text = selectedValue;
                                    });
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        controller: widget.projetsExploitentController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Projets exploitant cette ressource ...',
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        controller: widget.commentaireController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: widget.communautaireOrIndividuelleController.text == 'Autre'
                              ? 'Précisez la propriété "Autre" ...'
                              : 'Commentaire ...',
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0F8A74), // Set the background color
                          ),

                          onPressed: () {
                            if (isEditing) {
                              // Perform edit action
                              DS.saveResource(Resource(
                                ressourceId:  widget.resId!,
                                ressource: widget.ressourceController.text,
                                descriptif: widget.descriptifController.text,
                                CommunautaireORindividuelle: widget.communautaireOrIndividuelleController.text,
                                nbreCitations: widget.nbreCitationsController.text,
                                projetsExploitent: widget.projetsExploitentController.text,
                                dowarId: widget.DowarId!,
                                userId: auth.currentUser?.uid ?? "defaultUserId",
                                commentaire: widget.commentaireController.text,
                              ));
                            } else {
                              // Perform add action
                              DS.saveResource(Resource(
                                ressourceId:  const Uuid().v4().toString(),
                                ressource: widget.ressourceController.text,
                                descriptif: widget.descriptifController.text,
                                CommunautaireORindividuelle: widget.communautaireOrIndividuelleController.text,
                                nbreCitations: widget.nbreCitationsController.text,
                                projetsExploitent: widget.projetsExploitentController.text,
                                dowarId: widget.DowarId!,
                                userId: auth.currentUser?.uid ?? "defaultUserId",
                                commentaire: widget.commentaireController.text,
                              ));
                            }
                            setState(() {
                              if (widget.isExpanded) {
                                // Save the entered values when expanding the container
                                widget.ressourceController.text = widget.ressourceController.text;
                                widget.descriptifController.text = widget.descriptifController.text;
                                widget.communautaireOrIndividuelleController.text =
                                    widget.communautaireOrIndividuelleController.text;
                                widget.nbreCitationsController.text = widget.nbreCitationsController.text;
                                widget.projetsExploitentController.text =
                                    widget.projetsExploitentController.text;
                                widget.commentaireController.text =widget.commentaireController.text;
                              }
                              widget.isExpanded = !widget.isExpanded;
                              isEditing = !isEditing;
                            });
                          },

                          child: Text(
                            "Ajouter",
                          )
                      )

                    ]),
                if(!widget.isExpanded)
                  Column(
                    children: [
                      SizedBox(height: getProportionateScreenHeight(5)),
                      Text(
                        widget.ressourceController.text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(15)),
                      Text(
                        widget.descriptifController.text,
                        style: TextStyle(fontSize: 12),
                      ),
                  ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
