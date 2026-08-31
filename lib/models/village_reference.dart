/// Représente une entrée de la base de référence des villages/localités du
/// Maroc, utilisée pour aider l'enquêteur à retrouver un village existant
/// (par nom) plutôt que d'en recréer un en doublon.
///
/// Source initiale des données : extraction GeoNames (villes/localités avec
/// population ≥ 500 habitants) — voir la remarque dans le compte-rendu sur
/// les limites de cette source pour les petits douars.
class VillageReference {
  String? id;
  String name;
  String region;
  String province;
  double latitude;
  double longitude;
  int population;
  String source;

  VillageReference({
    this.id,
    required this.name,
    this.region = '',
    this.province = '',
    required this.latitude,
    required this.longitude,
    this.population = 0,
    this.source = '',
  });

  factory VillageReference.fromJson(Map<String, dynamic> json, {String? id}) {
    return VillageReference(
      id: id,
      name: json['name'] ?? '',
      region: json['region'] ?? '',
      province: json['province'] ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      population: json['population'] ?? 0,
      source: json['source'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'region': region,
      'province': province,
      'latitude': latitude,
      'longitude': longitude,
      'population': population,
      'source': source,
    };
  }
}
