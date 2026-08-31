import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cci_app/data_space/controllers/data_space_controller.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:cci_app/models/acteurs_de_lemergence.dart';
import 'package:cci_app/services/type_list_service.dart';
import 'package:cci_app/config.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:cci_app/acteurs_de_lemergence/picker.dart';

class AddActeurPage extends StatefulWidget {
  final String? DowarId;
  final String? acterId;
  bool isExpanded;
  TextEditingController acteurController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController roleController =
  TextEditingController();
  TextEditingController depuisController = TextEditingController();
  TextEditingController commentaireController = TextEditingController();


  AddActeurPage({
    required this.DowarId,
    required this.isExpanded,
    required this.acteurController,
    required this.roleController,
    required this.depuisController,
    required this.typeController,
    required this.commentaireController,
    this.acterId,
  });

  @override
  _AddResourcePageState createState() => _AddResourcePageState();
}

class _AddResourcePageState extends State<AddActeurPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController DS = Get.put(DataSpeceController());
  final TypeListService typeListService = TypeListService();
  // Liste par défaut, remplacée par le contenu de Firestore
  // ('type_lists/acteurs_roles') si l'admin en a défini un (point 1).
  List<String> roleList = ['Intégrateur', 'Leader institutionnel', 'Faiseur', 'Catalyseur','Facilitateur','Non défini'];
  String? rl;
  // Define variables for the form fields


  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    typeListService.getValues('acteurs_roles', roleList).then((values) {
      if (mounted) {
        setState(() {
          roleList = values;
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

              // Populate form fields with existing values
              widget.acteurController.text = widget.acteurController.text;
              widget.typeController.text = widget.typeController.text;
              widget.roleController.text =
                  widget.roleController.text;
              widget.depuisController.text = widget.depuisController.text;
              widget.commentaireController.text = widget.commentaireController.text;
            });
          },
          child: AnimatedContainer(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(30),right:getProportionateScreenWidth(30)),
            duration: Duration(milliseconds: 300),
            width: getProportionateScreenWidth(400),
            height: widget.isExpanded ? getProportionateScreenHeight(490) : getProportionateScreenHeight(70),
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
                        "Ajouter un acteur de l'émergence",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(12)),
                      TextField(
                        controller: widget.acteurController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white, // replace with desired color
                          hintText: 'Acteur ...',
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        controller: widget.roleController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'role ...',
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        controller: widget.typeController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'type ...',
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return MyPickerWidget(
                                options: roleList,
                                onItemSelected: (selectedValue) {
                                  if (selectedValue != null) {
                                    setState(() {
                                      widget.typeController.text = selectedValue;
                                    });
                                  }
                                },
                                onSuggestNew: (newType) {
                                  typeListService.suggestType(
                                    'acteurs_roles',
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
                        controller: widget.depuisController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Depuis ...',
                        ),
                        onTap: () {
                          showStartDatePickerDialog();

                        },
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        controller: widget.commentaireController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
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
                              DS.saveActeur(Acteur(
                                acteurId: widget.acterId!, // Use the existing ID
                                acteur: widget.acteurController.text,
                                type: widget.typeController.text,
                                role: widget.roleController.text,
                                depuis: widget.depuisController.text,
                                dowarId: widget.DowarId!,
                                userId: auth.currentUser?.uid ?? "defaultUserId",
                                commentaire: widget.commentaireController.text,
                              ));
                            } else {
                              // Perform add action
                              DS.saveActeur(Acteur(
                                acteurId: const Uuid().v4().toString(),
                                acteur: widget.acteurController.text,
                                type: widget.typeController.text,
                                role: widget.roleController.text,
                                depuis: widget.depuisController.text,
                                dowarId: widget.DowarId!,
                                userId: auth.currentUser?.uid ?? "defaultUserId",
                                commentaire: widget.commentaireController.text,
                              ));
                            }
                            setState(() {
                              if (widget.isExpanded) {
                                // Save the entered values when expanding the container
                                widget.acteurController.text = widget.acteurController.text;
                                widget.typeController.text = widget.typeController.text;
                                widget.roleController.text = widget.roleController.text;
                                widget.depuisController.text = widget.depuisController.text;
                                widget.commentaireController.text = widget.commentaireController.text;
                              }
                              widget.isExpanded = !widget.isExpanded;
                              isEditing = !isEditing; // Reset the edit mode
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
                        widget.acteurController.text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(15)),
                      Text(
                        widget.roleController.text,
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
        widget.depuisController.text = formattedDate;
      });
    }
  }
  }

