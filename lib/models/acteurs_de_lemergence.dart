class Acteur {
  String acteurId;
  String acteur;
  String type;
  String role;
  String depuis;
  String commentaire;
  String dowarId;
  String userId;

  Acteur({
    required this.acteurId,
    required this.acteur,
    required this.type,
    required this.role,
    required this.depuis,
    required this.dowarId,
    required this.userId,
    required this.commentaire
  });

  factory Acteur.fromJson(Map<String, dynamic> json) {
    return Acteur(
      acteurId: json['acteurId'] ,
      acteur: json['acteur identifié'] ,
      type: json['type'] ,
      role: json['Rôle'] ,
      dowarId: json['dowarId'] ,
      depuis: json['Depuis'] ,
      userId: json['userId'] ,
      commentaire: json['commentaire']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['acteurId'] = acteurId;
    data['acteur identifié'] = acteur;
    data['type'] = type;
    data['Rôle'] = role;
    data['dowar'] = dowarId;
    data['Depuis'] = depuis;
    data['userId'] = userId;
    data['commentaire'] =commentaire;
    return data;
  }
}
