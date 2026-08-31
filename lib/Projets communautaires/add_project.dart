import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cci_app/data_space/controllers/data_space_controller.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:cci_app/models/Projets_communautaires.dart';
import 'package:cci_app/config.dart';
import 'package:intl/intl.dart';
import 'package:cci_app/Projets communautaires/picker.dart';

class AddProjetPage extends StatefulWidget {
  final String? DowarId;
  bool isExpanded;
  TextEditingController projetController = TextEditingController();
  TextEditingController descriptifController = TextEditingController();
  TextEditingController ActeursimpController =
  TextEditingController();
  TextEditingController resultatController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController initiateurController = TextEditingController();
  TextEditingController commentaireController = TextEditingController();
  String? pgId;

  AddProjetPage({
    required this.DowarId,
    required this.isExpanded,
    required this.projetController,
    required this.startDateController,
    required this.ActeursimpController,
    required this.resultatController,
    required this.descriptifController,
    required this.endDateController,
    required this.initiateurController,
    required this.commentaireController,
    this.pgId
  });

  @override
  _AddProjetPageState createState() => _AddProjetPageState();
}

class _AddProjetPageState extends State<AddProjetPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController DS = Get.put(DataSpeceController());
  final List<String> resultatList = ['non démarré','en cours', 'succès', 'échec', 'bloqué'];
  final List<String> initiateurlist = ['individu', 'collectif', 'communauté', 'entreprise externe', 'ONG externe', "Services de l'État", 'Autres'];

  // Define variables for the form fields


  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              widget.isExpanded = !widget.isExpanded;
              isEditing = true;

              widget.projetController.text = widget.projetController.text;
              widget.descriptifController.text = widget.descriptifController.text;
              widget.ActeursimpController.text =
                  widget.ActeursimpController.text;
              widget.resultatController.text = widget.resultatController.text;
              widget.startDateController.text =
                  widget.startDateController.text;
              widget.endDateController.text =
                  widget.endDateController.text;
              widget.initiateurController.text =widget.initiateurController.text;
              widget.commentaireController.text = widget.commentaireController.text;
            });
          },
          child: AnimatedContainer(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(30),right:getProportionateScreenWidth(30)),
            duration: Duration(milliseconds: 300),
            width: getProportionateScreenWidth(400),
            height: widget.isExpanded ? getProportionateScreenHeight(703) : getProportionateScreenHeight(70),
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
                          "Ajouter un projet communautaire",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(12)),
                        TextField(
                          controller: widget.projetController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white, // replace with desired color
                            hintText: 'Projet ...',
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
                          controller: widget.ActeursimpController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Acteurs impliqués ...',
                          ),
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        TextField(
                          controller: widget.initiateurController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Initiateur ...',
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return MyPickerWidget(
                                  options: initiateurlist,
                                  onItemSelected: (selectedValue) {
                                    if (selectedValue != null) {
                                      setState(() {
                                        widget.initiateurController.text = selectedValue;
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
                          controller: widget.resultatController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Etat ...',
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return MyPickerWidget(
                                  options: resultatList,
                                  onItemSelected: (selectedValue) {
                                    if (selectedValue != null) {
                                      setState(() {
                                        widget.resultatController.text = selectedValue;
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
                          controller: widget.startDateController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Date de début ...',
                          ),
                          onTap: () {
                            showStartDatePickerDialog();
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        TextField(
                          controller: widget.endDateController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Date de fin ...',
                          ),
                          onTap: () {
                            showEndDatePickerDialog();
                          },
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        TextField(
                          controller: widget.commentaireController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white, // replace with desired color
                            hintText: 'Commentaire ...',
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
                                DS.saveProjet(Projet(
                                  projetId:  widget.pgId!,
                                  projet: widget.projetController.text,
                                  descriptif: widget.descriptifController.text,
                                  Acteursimp: widget.ActeursimpController.text,
                                  initiateur: widget.initiateurController.text,
                                  resultat: widget.resultatController.text,
                                  startDate: widget.startDateController.text,
                                  endDate: widget.endDateController.text,
                                  dowarId: widget.DowarId!,
                                  userId: auth.currentUser?.uid ?? "defaultUserId",
                                  commentaire : widget.commentaireController.text,
                                ));
                              } else {
                                // Perform add action
                                DS.saveProjet(Projet(
                                  projetId:  const Uuid().v4().toString(),
                                  projet: widget.projetController.text,
                                  descriptif: widget.descriptifController.text,
                                  Acteursimp: widget.ActeursimpController.text,
                                  initiateur: widget.initiateurController.text,
                                  resultat: widget.resultatController.text,
                                  startDate: widget.startDateController.text,
                                  endDate: widget.endDateController.text,
                                  dowarId: widget.DowarId!,
                                  userId: auth.currentUser?.uid ?? "defaultUserId",
                                  commentaire : widget.commentaireController.text,
                                ));
                              }
                              setState(() {
                                if (widget.isExpanded) {
                                  // Save the entered values when expanding the container
                                  widget.projetController.text = widget.projetController.text;
                                  widget.descriptifController.text = widget.descriptifController.text;
                                  widget.ActeursimpController.text =
                                      widget.ActeursimpController.text;
                                  widget.resultatController.text = widget.resultatController.text;
                                  widget.startDateController.text =
                                      widget.startDateController.text;
                                  widget.endDateController.text =
                                      widget.endDateController.text;
                                  widget.initiateurController.text =widget.initiateurController.text;
                                  widget.commentaireController.text = widget.commentaireController.text;
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
                          widget.projetController.text,
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
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  void showStartDatePickerDialog() async {
    final DateTime? selectedStartDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF0F8A74), // Customize primary color
            colorScheme: ColorScheme.light(
              primary: Color(0xFF0F8A74), // Customize primary color
              onPrimary: Colors.white, // Customize text color on primary color
              surface: Colors.white, // Customize background color
              onSurface: Colors.black, // Customize text color on background color
            ),
          ),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (selectedStartDate != null) {
      String formattedDate = _dateFormat.format(selectedStartDate);
      setState(() {
        widget.startDateController.text = formattedDate;
      });
    }
  }
  void showEndDatePickerDialog() async {
    final DateTime? selectedEndDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF0F8A74), // Customize primary color
            colorScheme: ColorScheme.light(
              primary: Color(0xFF0F8A74), // Customize primary color
              onPrimary: Colors.white, // Customize text color on primary color
              surface: Colors.white, // Customize background color
              onSurface: Colors.black, // Customize text color on background color
            ),
          ),
          child: child ?? const SizedBox(),
        );
      },
    );

    if (selectedEndDate != null) {
      String formattedDate = _dateFormat.format(selectedEndDate);
      setState(() {
        widget.endDateController.text = formattedDate;
      });
    }
  }


}
