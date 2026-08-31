import 'dart:io';
import 'package:cci_app/models/media.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import '../utils/database_roots.dart';

class UploadMediaService {


  Future<String> uploadFile(File file, String folderName) async {
    String fileName = const Uuid().v4(); // Generate a unique file name
    Reference reference =
        DatabaseRoutes.STORAGE_REFERENCE.child('$folderName/$fileName');
    UploadTask uploadTask = reference.putFile(file);

    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    // Get the uploaded image URL
    String downloadUrl = await reference.getDownloadURL();

    return downloadUrl;
  }
  Future<void> save_media(Media media) async {
    await DatabaseRoutes.MEDIA_DATABASES.doc(media.mediaId.toString()).set(media.toJson());

  }
}
