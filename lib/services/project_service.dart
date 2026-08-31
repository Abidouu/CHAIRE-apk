import '../utils/database_roots.dart';
import 'package:cci_app/models/Projets_communautaires.dart';


class projetservice{
  Future<void> saveProjet(Projet pg) async {
    await DatabaseRoutes.PROJET_DATABASES.doc().set(pg.toJson());
  }

}