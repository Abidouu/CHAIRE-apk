import 'package:cci_app/models/Ressource_local.dart';
import '../utils/database_roots.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class resource_service{
  Future<void> saveRessource(Resource res) async {
    await DatabaseRoutes.RESSOURCE_DATABASES.doc().set(res.toJson());
  }

}