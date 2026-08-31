import 'package:cci_app/models/infrastructures_de_base.dart';
import '../utils/database_roots.dart';


class infrastructure_service{
  Future<void> saveinfratstructure(Infrastructure inf) async {
    await DatabaseRoutes.INFRASTRUCTURE_DATABASES.doc().set(inf.toJson());
  }

}