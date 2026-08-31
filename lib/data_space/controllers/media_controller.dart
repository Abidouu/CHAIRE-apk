import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import '../../models/media.dart';
import 'package:cci_app/login/login_repository.dart';

class MediaConroller extends GetxController {
  Future<Media> createMedia(String Description, String Type, String url) async{
    Media media = Media();
    media.mediaId = const Uuid().v4();
    media.mediaType = Type;
    media.mediaUrl = url;
    media.mediaDescription = Description;
    media.userId = await LoginRepository().getConnectedUserId();
    media.dowarId = 'test';
    return  media;

  }

  


}
