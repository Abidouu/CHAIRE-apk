

import 'package:cci_app/models/acteurs_de_lemergence.dart';
import 'package:cci_app/models/media.dart';
import 'package:cci_app/services/Acteur_service.dart';
import 'package:cci_app/services/response_service.dart';
import 'package:get/get.dart';
import '../../models/intervale.dart';
import '../../models/Ressource_local.dart';
import 'package:cci_app/models/responce.dart' as resp;
import '../../services/upload_media_services.dart';
import 'package:cci_app/models/Projets_communautaires.dart';
import 'package:cci_app/services/project_service.dart';
import 'package:cci_app/services/ressource_service.dart';
import 'package:cci_app/models/infrastructures_de_base.dart';
import 'package:cci_app/services/infrastructure_service.dart';

class DataSpeceController extends GetxController {

  var responses = <resp.Response>[].obs;
  var medias = <Media>[].obs;
  var intervals = <CoordinateInterval>[].obs;
  var ressources = <Resource>[].obs;
  var projets = <Projet>[].obs;
  var infrastructures = <Infrastructure>[].obs;
  var acteurs =<Acteur>[].obs;

  void saveMedia(Media media) {
    medias.add(media);
  }
  void saveResponse(resp.Response response) {
    int existingIndex = responses.indexWhere((r) => r.questionId == response.questionId);

    if (existingIndex != -1) {
      // Update existing response
      responses[existingIndex] = response;
    } else {
      // Add new response
      responses.add(response);
    }
  }

  void saveResource(Resource Rs) {
    int existingIndex = ressources.indexWhere((r) => r.ressourceId == Rs.ressourceId);

    if (existingIndex != -1) {
      // Update existing response
      ressources[existingIndex] = Rs;
    } else {
      // Add new response
      ressources.add(Rs);
    }
  }
  void saveProjet(Projet pg) {
    int existingIndex = projets.indexWhere((p) => p.projetId == pg.projetId);

    if (existingIndex != -1) {
      // Update existing response
      projets[existingIndex] = pg;
    } else {
      // Add new response
      projets.add(pg);
    }
  }
  void saveInfrastructure(Infrastructure inf) {
    int existingIndex = infrastructures.indexWhere((i) => i.infrastructureId == inf.infrastructureId);

    if (existingIndex != -1) {
      // Update existing response
      infrastructures[existingIndex] = inf;
    } else {
      // Add new response
      infrastructures.add(inf);
    }
  }
  void saveActeur(Acteur ac) {
    int existingIndex = acteurs.indexWhere((a) => a.acteurId == ac.acteurId);

    if (existingIndex != -1) {
      // Update existing response
      acteurs[existingIndex] = ac;
    } else {
      // Add new response
      acteurs.add(ac);
    }
  }


  Future<String> saveDataToFirebase() async{
    for(Media md in medias){
      await UploadMediaService().save_media(md);
    }
    for(resp.Response respon in responses){
      ResponseService().saveResponse(respon);
    }
    for(Resource rs in ressources){
      resource_service().saveRessource(rs);
    }
    for(Projet pg in projets){
      projetservice().saveProjet(pg);
    }
    for(Acteur ac in acteurs){
      acteur_service().saveActeur(ac);
    }
    for(Infrastructure inf in infrastructures){
      infrastructure_service().saveinfratstructure(inf);
    }

    return 'done';

  }
  Future<String> deleteCash() async{
    responses.clear();
    medias.clear();
    projets.clear();
    ressources.clear();
    acteurs.clear();
    infrastructures.clear();
    return 'done';
  }

}