import 'package:cci_app/services/Date_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/responce.dart';
import '../utils/database_roots.dart';

class ResponseService {
  

  // Get all responses from Firebase
  Future<List<Response>> getAllResponses() async {
    QuerySnapshot<Object?> querySnapshot =
        await DatabaseRoutes.RENSPONSE_DATABASES.get();
    List<Response> responses = querySnapshot.docs
        .map((doc) => Response.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return responses;
  }

  // Get a response by its ID from Firebase
  Future<Response?> getResponseById(double id) async {
    DocumentSnapshot<Object?> documentSnapshot =
        await DatabaseRoutes.RENSPONSE_DATABASES.doc(id.toString()).get();
    if (documentSnapshot.exists) {
      return Response.fromJson(documentSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  // Save a response to Firebase
  Future<void> saveResponse(Response response) async {
    await DatabaseRoutes.RENSPONSE_DATABASES.doc(response.responseId.toString()).set(response.toJson());
  }

  // Get all responses with a matching question_id from Firebase
  Future<List<Response>> getQuestionResponses(double questionId) async {
    QuerySnapshot<Object?> querySnapshot = await DatabaseRoutes.RENSPONSE_DATABASES
        .where('question_id', isEqualTo: questionId)
        .get();
    List<Response> responses = querySnapshot.docs
        .map((doc) => Response.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return responses;
  }
}
