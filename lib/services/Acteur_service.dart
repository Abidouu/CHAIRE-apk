import 'package:cci_app/models/acteurs_de_lemergence.dart';
import '../utils/database_roots.dart';


class acteur_service{
  Future<void> saveActeur(Acteur ac) async {
    await DatabaseRoutes.ACTEUR_DATABASES.doc().set(ac.toJson());
  }

}