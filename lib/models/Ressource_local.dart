class Resource {
  String ressourceId;
  String ressource;
  String descriptif;
  String CommunautaireORindividuelle;
  String nbreCitations;
  String projetsExploitent;
  String dowarId;
  String userId;
  String commentaire;

  Resource({
    required this.ressourceId,
    required this.ressource,
    required this.descriptif,
    required this.CommunautaireORindividuelle,
    required this.nbreCitations,
    required this.projetsExploitent,
    required this.dowarId,
    required this.userId,
    required this.commentaire
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    return Resource(
      ressourceId: json['ressourceId'] ,
      ressource: json['ressource'] ,
      descriptif: json['descriptif'] ,
      CommunautaireORindividuelle: json['CommunautaireORindividuelle'] ,
      dowarId: json['dowarId'] ,
      nbreCitations: json['nbreCitations'] ,
      projetsExploitent: json['projetsExploitent'] ,
      userId: json['userId'] ,
      commentaire: json['commentaire'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ressourceId'] = ressourceId;
    data['ressource'] = ressource;
    data['descriptif'] = descriptif;
    data['CommunautaireORindividuelle'] = CommunautaireORindividuelle;
    data['dowar'] = dowarId;
    data['nbreCitations'] = nbreCitations;
    data['projetsExploitent'] = projetsExploitent;
    data['userId'] = userId;
    data['commentaire']= commentaire;
    return data;
  }
}
