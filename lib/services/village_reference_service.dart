import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/village_reference.dart';
import '../utils/database_roots.dart';

/// Recherche des localités dans la base de référence des villages du Maroc
/// (collection `villages_maroc`), pour aider l'enquêteur à retrouver un
/// village existant par son nom plutôt que d'en recréer un en double.
class VillageReferenceService {
  /// Recherche par préfixe de nom (insensible à la casse impossible
  /// nativement dans Firestore : les noms sont donc aussi stockés en
  /// minuscules dans `name_lowercase` lors de l'import, pour permettre
  /// cette recherche).
  Future<List<VillageReference>> searchByName(String query) async {
    if (query.trim().isEmpty) return [];
    final String q = query.trim().toLowerCase();
    final QuerySnapshot<Object?> snapshot = await DatabaseRoutes.VILLAGE_REFERENCE_DATABASES
        .orderBy('name_lowercase')
        .startAt([q])
        .endAt(['$q\uf8ff'])
        .limit(15)
        .get();

    return snapshot.docs
        .map((doc) => VillageReference.fromJson(doc.data() as Map<String, dynamic>, id: doc.id))
        .toList();
  }
}
