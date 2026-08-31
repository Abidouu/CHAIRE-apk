class TypeSuggestion {
  String suggestionId;
  // Catégorie de la liste concernée (ex. 'infrastructures', 'acteurs_roles',
  // 'ressources_proprietaire') — permet de généraliser le mécanisme à toutes
  // les listes de types de l'application (demande d'Ahmed).
  String category;
  String value;
  // 'pending' (en attente), 'validated' (validé par un chercheur) ou 'rejected'.
  String status;
  String proposedByUserId;
  String? dowarId;
  String createdAt;

  TypeSuggestion({
    required this.suggestionId,
    required this.category,
    required this.value,
    this.status = 'pending',
    required this.proposedByUserId,
    this.dowarId,
    required this.createdAt,
  });

  factory TypeSuggestion.fromJson(Map<String, dynamic> json) {
    return TypeSuggestion(
      suggestionId: json['suggestionId'],
      category: json['category'],
      value: json['value'],
      status: json['status'] ?? 'pending',
      proposedByUserId: json['proposedByUserId'],
      dowarId: json['dowarId'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'suggestionId': suggestionId,
      'category': category,
      'value': value,
      'status': status,
      'proposedByUserId': proposedByUserId,
      'dowarId': dowarId,
      'createdAt': createdAt,
    };
  }
}
