class Infrastructure {
  String infrastructureId;
  String infrastructure;
  // Stockait un "Oui/Non" ; contient désormais une quantité (point 4 de l'e-mail d'Ahmed).
  String Disponible;
  String qualite_percue;
  String distance;
  String Suffisant;
  String etat;
  String encours;
  String dowarId;
  String userId;
  String commentaire;
  String generationRevenus;
  // --- Champs liés au statut de l'infrastructure (point 8) ---
  String statut;
  String priorite;
  String etudeTechnique;
  String budget;
  String financement;
  String dateLancement;
  String dateFin;
  String financementMateriel;
  String financementMainOeuvre;

  Infrastructure({
    required this.infrastructureId,
    required this.infrastructure,
    required this.Disponible,
    required this.qualite_percue,
    required this.Suffisant,
    required this.etat,
    required this.dowarId,
    required this.userId,
    required this.distance,
    required this.encours,
    required this.commentaire,
    this.generationRevenus = '',
    this.statut = '',
    this.priorite = '',
    this.etudeTechnique = '',
    this.budget = '',
    this.financement = '',
    this.dateLancement = '',
    this.dateFin = '',
    this.financementMateriel = '',
    this.financementMainOeuvre = ''
  });

  factory Infrastructure.fromJson(Map<String, dynamic> json) {
    return Infrastructure(
      infrastructureId: json['infrastructureId'] ,
      infrastructure: json['infrastructure'] ,
      Disponible: json['Disponible'] ,
      qualite_percue: json['Qualité perçue'] ,
      // Ce champ stockait la distance ; il contient désormais le temps d'accès (point 6 de l'e-mail d'Ahmed).
      distance : json['Distance'],
      dowarId: json['dowarId'] ,
      Suffisant: json['Suffisant aux besoins'] ,
      etat: json['etat'] ,
      userId: json['userId'] ,
      encours: json['Projets en cours ou planifiés'],
      commentaire: json['commentaire'],
      // Champs absents sur les fiches enregistrées avant cette mise à jour : valeur par défaut vide.
      generationRevenus: json['Génération de revenus'] ?? '',
      statut: json['Statut'] ?? '',
      priorite: json['Priorité'] ?? '',
      etudeTechnique: json['Étude technique'] ?? '',
      budget: json['Budget établi'] ?? '',
      financement: json['Financement acquis'] ?? '',
      dateLancement: json['Date de lancement prévue'] ?? '',
      dateFin: json['Date de fin prévue'] ?? '',
      financementMateriel: json['Financement matériel'] ?? '',
      financementMainOeuvre: json['Financement main d\'œuvre'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['infrastructureId'] = infrastructureId;
    data['infrastructure'] = infrastructure;
    data['Disponible'] = Disponible;
    data['Qualité perçue'] = qualite_percue;
    data['dowar'] = dowarId;
    data['Suffisant aux besoins'] = Suffisant;
    data['etat'] = etat;
    data['Distance']= distance;
    data['userId'] = userId;
    data['Projets en cours ou planifiés'] = encours;
    data['commentaire']= commentaire;
    data['Génération de revenus'] = generationRevenus;
    data['Statut'] = statut;
    data['Priorité'] = priorite;
    data['Étude technique'] = etudeTechnique;
    data['Budget établi'] = budget;
    data['Financement acquis'] = financement;
    data['Date de lancement prévue'] = dateLancement;
    data['Date de fin prévue'] = dateFin;
    data['Financement matériel'] = financementMateriel;
    data['Financement main d\'œuvre'] = financementMainOeuvre;
    return data;
  }
}
