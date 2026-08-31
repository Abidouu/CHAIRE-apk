import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cci_app/data_space/controllers/data_space_controller.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:cci_app/models/infrastructures_de_base.dart';
import 'package:cci_app/services/type_list_service.dart';
import 'package:cci_app/config.dart';
import 'package:cci_app/infrastructures_de_base/picker.dart';


class AddInfrastructurePage extends StatefulWidget {
  final String? DowarId;
  final String? infId;
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isExpanded;
  TextEditingController infrastructureController = TextEditingController();
  // Ce champ stockait un simple "Oui/Non" (Disponible). Il stocke désormais la
  // quantité disponible (point 4 de l'e-mail d'Ahmed : "un village qui a 2 puits
  // est différent d'un village qui n'en a qu'un"), saisie via un compteur +/-.
  TextEditingController disponibleController = TextEditingController();
  TextEditingController qualite_percueController =
  TextEditingController();
  TextEditingController suffisantController = TextEditingController();
  TextEditingController etatController = TextEditingController();
  TextEditingController distanceController = TextEditingController();
  // Conservé pour compatibilité avec les fiches existantes ; n'est plus affiché
  // dans le formulaire, remplacé par le champ "statut" ci-dessous (point 8).
  TextEditingController encoursController = TextEditingController();
  TextEditingController commentaireController = TextEditingController();
  TextEditingController revenusController = TextEditingController();
  // --- Nouveaux champs liés au statut de l'infrastructure (point 8) ---
  TextEditingController statutController = TextEditingController();
  TextEditingController prioriteController = TextEditingController();
  TextEditingController etudeTechniqueController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  TextEditingController financementController = TextEditingController();
  TextEditingController dateLancementController = TextEditingController();
  TextEditingController dateFinController = TextEditingController();
  TextEditingController financementMaterielController = TextEditingController();
  TextEditingController financementMainOeuvreController = TextEditingController();

  AddInfrastructurePage({
    required this.DowarId,
    required this.isExpanded,
    required this.infrastructureController,
    required this.etatController,
    required this.qualite_percueController,
    required this.suffisantController,
    required this.disponibleController,
    required this.distanceController,
    required this.encoursController,
    required this.commentaireController,
    TextEditingController? revenusController,
    TextEditingController? statutController,
    TextEditingController? prioriteController,
    TextEditingController? etudeTechniqueController,
    TextEditingController? budgetController,
    TextEditingController? financementController,
    TextEditingController? dateLancementController,
    TextEditingController? dateFinController,
    TextEditingController? financementMaterielController,
    TextEditingController? financementMainOeuvreController,
    this.infId
  }) : revenusController = revenusController ?? TextEditingController(),
       statutController = statutController ?? TextEditingController(),
       prioriteController = prioriteController ?? TextEditingController(),
       etudeTechniqueController = etudeTechniqueController ?? TextEditingController(),
       budgetController = budgetController ?? TextEditingController(),
       financementController = financementController ?? TextEditingController(),
       dateLancementController = dateLancementController ?? TextEditingController(),
       dateFinController = dateFinController ?? TextEditingController(),
       financementMaterielController = financementMaterielController ?? TextEditingController(),
       financementMainOeuvreController = financementMainOeuvreController ?? TextEditingController();

  @override
  _AddInfrastructurePageState createState() => _AddInfrastructurePageState();
}

class _AddInfrastructurePageState extends State<AddInfrastructurePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final DataSpeceController DS = Get.put(DataSpeceController());
  final TypeListService typeListService = TypeListService();
  // Liste par défaut, utilisée tant que l'admin n'a pas défini de liste
  // personnalisée dans Firestore (collection 'type_lists', document
  // 'infrastructures', champ 'values') — voir TypeListService.
  List<String> infrastructureList = ['Electricité', 'Eau pour irrigation', 'Eau potable', 'Eau courante dans les foyers','Réseau GSM','Réseau Internet','Préscolaire','Ecole primaire','Collège','Lycée','Formations techniques','Internat','Route d’accès','Dispensaire/infirmerie','Hôpital','Centre maternel','Pharmacie','Ambulance','Dar Talib','Dar Chabab','Dar Attakafa','Souk hebdomadaire','Sports et jeunesse','Mosquée','Autre : '];
  final List<String> ONList = ['Oui', 'Non'];
  final List<String> ETList = ['Individuel', 'collectif', 'communautaire', 'entreprise externe','ONG externe',"Services de l'État","Autres"];
  final List<String> QPList = ['TB', 'B', 'M', 'F','TF'];
  final List<String> TAList = ['Au centre du village', 'À moins de 10 min à pied', 'À moins de 30 min', 'À moins d\'une heure', 'À plus d\'une heure'];
  final List<String> RGList = ['Ne génère pas de revenus', 'Pour l\'association du village', 'Pour la communauté dans son ensemble', 'Pour quelques membres de la communauté', 'Pour des individus ou organisations hors de la communauté'];
  final List<String> StatutList = ['Existante', 'En cours', 'Planifiée'];
  final List<String> PrioriteList = ['1', '2', '3', '4', '5'];
  final List<String> FinancementMaterielList = ['Association du village / contribution financière de la communauté', 'Partenaire privé/associatif', 'Bienfaiteur', 'État', 'Mixte (préciser en commentaire)'];
  final List<String> FinancementMainOeuvreList = ['Twiza/Tiwiza (entraide villageoise)', 'Association du village / contribution financière de la communauté', 'Partenaire privé/associatif', 'Bienfaiteur', 'État', 'Mixte (préciser en commentaire)'];
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  // Define variables for the form fields


  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    typeListService.getValues('infrastructures', infrastructureList).then((values) {
      if (mounted) {
        setState(() {
          infrastructureList = values;
        });
      }
    });
  }

  // Le statut par défaut, pour les fiches déjà enregistrées avant l'ajout de ce
  // champ, est "Existante" (comportement d'origine du formulaire).
  String get _statut => widget.statutController.text.isEmpty ? 'Existante' : widget.statutController.text;

  int get _quantite => int.tryParse(widget.disponibleController.text) ?? 1;

  Future<void> _pickDate(TextEditingController controller) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Color(0xFF0F8A74),
            colorScheme: ColorScheme.light(
              primary: Color(0xFF0F8A74),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child ?? const SizedBox(),
        );
      },
    );
    if (selected != null) {
      setState(() {
        controller.text = _dateFormat.format(selected);
      });
    }
  }

  Widget _buildPickerField({
    required TextEditingController controller,
    required String hint,
    required List<String> options,
  }) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return MyPickerWidget(
              options: options,
              onItemSelected: (selectedValue) {
                if (selectedValue != null) {
                  setState(() {
                    controller.text = selectedValue;
                  });
                }
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDateField({required TextEditingController controller, required String hint}) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hint,
      ),
      onTap: () => _pickDate(controller),
    );
  }

  Widget _buildQuantiteStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Quantité disponible', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        Row(
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle_outline),
              onPressed: () {
                setState(() {
                  if (_quantite > 0) {
                    widget.disponibleController.text = (_quantite - 1).toString();
                  }
                });
              },
            ),
            Text(_quantite.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            IconButton(
              icon: Icon(Icons.add_circle_outline),
              onPressed: () {
                setState(() {
                  widget.disponibleController.text = (_quantite + 1).toString();
                });
              },
            ),
          ],
        ),
      ],
    );
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

              widget.infrastructureController.text = widget.infrastructureController.text;
              widget.disponibleController.text = widget.disponibleController.text;
              widget.qualite_percueController.text =
                  widget.qualite_percueController.text;
              widget.suffisantController.text = widget.suffisantController.text;
              widget.etatController.text =
                  widget.etatController.text;
              widget.encoursController.text = widget.encoursController.text;
              widget.distanceController.text = widget.distanceController.text;
              widget.commentaireController.text = widget.commentaireController.text;

            });
          },
          child: AnimatedContainer(
            padding: EdgeInsets.only(left: getProportionateScreenWidth(30),right:getProportionateScreenWidth(30)),
            duration: Duration(milliseconds: 300),
            width: getProportionateScreenWidth(400),
            height: widget.isExpanded ? getProportionateScreenHeight(_statut == 'Existante' ? 850 : (_statut == 'Planifiée' ? 950 : 1050)) : getProportionateScreenHeight(70),
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
                        "Ajouter un infrastructure de base",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(12)),
                      TextField(
                        controller: widget.infrastructureController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Infrastructure de base ...',
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return MyPickerWidget(
                                options: infrastructureList,
                                onItemSelected: (selectedValue) {
                                  if (selectedValue != null) {
                                    setState(() {
                                      widget.infrastructureController.text = selectedValue;
                                    });
                                  }
                                },
                                onSuggestNew: (newType) {
                                  typeListService.suggestType(
                                    'infrastructures',
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
                      // Point 8 : le statut de l'infrastructure sert de filtre pour
                      // déterminer les questions suivantes (existante / en cours / planifiée).
                      _buildPickerField(
                        controller: widget.statutController,
                        hint: 'Statut de l\'infrastructure ...',
                        options: StatutList,
                      ),
                      if (_statut == 'Existante') ...[
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildQuantiteStepper(),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildPickerField(
                          controller: widget.qualite_percueController,
                          hint: 'Qualité perçue par les habitants ...',
                          options: QPList,
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildPickerField(
                          controller: widget.suffisantController,
                          hint: ' Suffisant aux besoins...',
                          options: ONList,
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildPickerField(
                          controller: widget.etatController,
                          hint: 'Propriété...',
                          options: ETList,
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildPickerField(
                          controller: widget.distanceController,
                          hint: 'Temps d\'accès à l\'infrastructure ...',
                          options: TAList,
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildPickerField(
                          controller: widget.revenusController,
                          hint: 'Génération de revenus ...',
                          options: RGList,
                        ),
                      ],
                      if (_statut == 'Planifiée') ...[
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildPickerField(
                          controller: widget.prioriteController,
                          hint: 'Priorité accordée par la communauté (1 à 5) ...',
                          options: PrioriteList,
                        ),
                      ],
                      if (_statut == 'Planifiée' || _statut == 'En cours') ...[
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildPickerField(
                          controller: widget.etudeTechniqueController,
                          hint: 'Étude technique réalisée ?',
                          options: ONList,
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildPickerField(
                          controller: widget.budgetController,
                          hint: 'Budget établi ?',
                          options: ONList,
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildPickerField(
                          controller: widget.financementController,
                          hint: 'Financement acquis ?',
                          options: ONList,
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildDateField(
                          controller: widget.dateLancementController,
                          hint: 'Date de lancement prévue ...',
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildDateField(
                          controller: widget.dateFinController,
                          hint: 'Date de fin prévue ...',
                        ),
                      ],
                      if (_statut == 'En cours') ...[
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildPickerField(
                          controller: widget.financementMaterielController,
                          hint: 'Financement des matières et fournitures ...',
                          options: FinancementMaterielList,
                        ),
                        SizedBox(height: getProportionateScreenHeight(8)),
                        _buildPickerField(
                          controller: widget.financementMainOeuvreController,
                          hint: 'Financement de la main-d\'œuvre ...',
                          options: FinancementMainOeuvreList,
                        ),
                      ],
                      SizedBox(height: getProportionateScreenHeight(8)),
                      TextField(
                        controller: widget.commentaireController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: widget.infrastructureController.text == 'Autre : '
                              ? 'Précisez l\'infrastructure "Autre" ...'
                              : 'Commentaire ...',
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0F8A74), // Set the background color
                          ),
                          onPressed: () {
                            // Le champ "Projets en cours ou planifiés" (encours) est conservé
                            // pour compatibilité mais n'est plus saisi directement : il est
                            // déduit du nouveau champ statut (point 8).
                            widget.encoursController.text = _statut == 'Existante' ? 'Non' : 'Oui';
                            if (isEditing) {
                              // Perform edit action
                              DS.saveInfrastructure(Infrastructure(
                                  infrastructureId:  widget.infId!,
                                  infrastructure: widget.infrastructureController.text,
                                  Disponible: widget.disponibleController.text,
                                  qualite_percue: widget.qualite_percueController.text,
                                  Suffisant: widget.suffisantController.text,
                                  etat: widget.etatController.text,
                                  dowarId: widget.DowarId!,
                                  userId: auth.currentUser?.uid ?? "defaultUserId",
                                  encours: widget.encoursController.text,
                                  distance : widget.distanceController.text,
                                  generationRevenus: widget.revenusController.text,
                                  statut: widget.statutController.text,
                                  priorite: widget.prioriteController.text,
                                  etudeTechnique: widget.etudeTechniqueController.text,
                                  budget: widget.budgetController.text,
                                  financement: widget.financementController.text,
                                  dateLancement: widget.dateLancementController.text,
                                  dateFin: widget.dateFinController.text,
                                  financementMateriel: widget.financementMaterielController.text,
                                  financementMainOeuvre: widget.financementMainOeuvreController.text,
                                commentaire: widget.commentaireController.text
                              ));
                            } else {
                              // Perform add action
                              DS.saveInfrastructure(Infrastructure(
                                infrastructureId:  const Uuid().v4().toString(),
                                infrastructure: widget.infrastructureController.text,
                                Disponible: widget.disponibleController.text,
                                qualite_percue: widget.qualite_percueController.text,
                                Suffisant: widget.suffisantController.text,
                                etat: widget.etatController.text,
                                dowarId: widget.DowarId!,
                                userId: auth.currentUser?.uid ?? "defaultUserId",
                                encours: widget.encoursController.text,
                                distance : widget.distanceController.text,
                                generationRevenus: widget.revenusController.text,
                                statut: widget.statutController.text,
                                priorite: widget.prioriteController.text,
                                etudeTechnique: widget.etudeTechniqueController.text,
                                budget: widget.budgetController.text,
                                financement: widget.financementController.text,
                                dateLancement: widget.dateLancementController.text,
                                dateFin: widget.dateFinController.text,
                                financementMateriel: widget.financementMaterielController.text,
                                financementMainOeuvre: widget.financementMainOeuvreController.text,
                                commentaire: widget.commentaireController.text
                              ));
                            }
                                  setState(() {
                              if (widget.isExpanded) {
                              // Save the entered values when expanding the container
                              widget.infrastructureController.text = widget.infrastructureController.text;
                              widget.disponibleController.text = widget.disponibleController.text;
                              widget.qualite_percueController.text =
                              widget.qualite_percueController.text;
                              widget.suffisantController.text = widget.suffisantController.text;
                              widget.etatController.text =
                              widget.etatController.text;
                              widget.encoursController.text = widget.encoursController.text;
                              widget.distanceController.text = widget.distanceController.text;
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
                        widget.infrastructureController.text,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(15)),
                      Text(
                        widget.disponibleController.text,
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
