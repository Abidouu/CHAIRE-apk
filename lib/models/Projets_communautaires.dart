class Projet {
  String projetId;
  String projet;
  String descriptif;
  String Acteursimp;
  String startDate;
  String endDate;
  String dowarId;
  String userId;
  String resultat;
  String initiateur;
  String commentaire;

  Projet({
    required this.projetId,
    required this.projet,
    required this.descriptif,
    required this.Acteursimp,
    required this.startDate,
    required this.endDate,
    required this.dowarId,
    required this.userId,
    required this.resultat,
    required this.initiateur,
    required this.commentaire
  });

  factory Projet.fromJson(Map<String, dynamic> json) {
    return Projet(
        projetId: json['projetId'] ,
        projet: json['projet'] ,
        descriptif: json['descriptif'] ,
        Acteursimp: json['Acteurs impliqués'] ,
        dowarId: json['dowarId'] ,
        startDate: json['Date de début'] ,
        endDate: json['Date de fin'] ,
        userId: json['userId'] ,
        resultat:  json['Résultat'],
        initiateur: json['initiateur'],
      commentaire: json['commentaire']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projetId'] = projetId;
    data['projet'] = projet;
    data['descriptif'] = descriptif;
    data['Acteurs impliqués'] = Acteursimp;
    data['dowar'] = dowarId;
    data['Date de début'] = startDate;
    data['Date de fin'] = endDate;
    data['userId'] = userId;
    data['Résultat']= resultat;
    data['initiateur']= initiateur;
    data['commentaire']= commentaire;
    return data;
  }
}
