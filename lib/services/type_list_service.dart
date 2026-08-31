import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../models/type_suggestion.dart';
import '../utils/database_roots.dart';

/// Gère les listes de types "paramétrables par l'admin" (ex. types
/// d'infrastructures, rôles d'acteurs, propriétés de ressources).
///
/// Fonctionnement :
/// - Un admin/chercheur peut éditer directement, dans la console Firebase,
///   le document `type_lists/{category}` (champ `values`, tableau de chaînes)
///   pour ajouter, retirer ou reformuler des options — sans toucher au code
///   ni republier l'application (demande d'Ahmed : liste "paramétrable par
///   l'admin dans le backend"). Tant qu'aucun document n'existe pour une
///   catégorie, la liste par défaut codée dans l'application est utilisée :
///   rien ne casse avant que l'admin n'ait renseigné Firestore.
/// - Un enquêteur qui ne trouve pas le type qu'il cherche peut proposer un
///   nouveau type via [suggestType] : la proposition est enregistrée avec le
///   statut "pending" dans `type_suggestions`, et n'apparaît PAS
///   automatiquement dans la liste utilisée sur le terrain — elle doit être
///   validée par un chercheur (en changeant son statut à "validated" dans la
///   console Firebase, ou via un futur écran d'administration) avant d'être
///   ajoutée au document `type_lists/{category}` correspondant.
class TypeListService {
  /// Renvoie la liste de valeurs pour [category], depuis Firestore si un
  /// document existe et contient des valeurs, sinon [fallbackDefaults].
  Future<List<String>> getValues(String category, List<String> fallbackDefaults) async {
    try {
      final doc = await DatabaseRoutes.TYPE_LIST_DATABASES.doc(category).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>?;
        final List<dynamic>? values = data?['values'] as List<dynamic>?;
        if (values != null && values.isNotEmpty) {
          return values.map((v) => v.toString()).toList();
        }
      }
    } catch (_) {
      // En cas d'erreur réseau/Firestore, on retombe sur la liste par défaut
      // plutôt que de bloquer la saisie sur le terrain.
    }
    return fallbackDefaults;
  }

  /// Enregistre une proposition de nouveau type, en attente de validation
  /// par un chercheur. Ne modifie PAS la liste active.
  Future<void> suggestType(String category, String value, String userId, {String? dowarId}) async {
    final suggestion = TypeSuggestion(
      suggestionId: const Uuid().v4().toString(),
      category: category,
      value: value,
      status: 'pending',
      proposedByUserId: userId,
      dowarId: dowarId,
      createdAt: DateTime.now().toIso8601String(),
    );
    await DatabaseRoutes.TYPE_SUGGESTION_DATABASES
        .doc(suggestion.suggestionId)
        .set(suggestion.toJson());
  }
}
