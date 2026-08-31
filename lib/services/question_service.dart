import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/question.dart';
import '../models/responce.dart';
import '../utils/database_roots.dart';

class QuestionService {
  Future<List<Question>> getAllQuestions() async {
    final QuerySnapshot<Object?> querySnapshot =
        await DatabaseRoutes.QUESTION_DATABASES.get();
    return querySnapshot.docs
        .map((doc) => Question.fromJson(doc.data()! as Map<String, dynamic>))
        .toList();
  }

  Future<Question?> getQuestionById(double id) async {
    final QuerySnapshot<Object?> querySnapshot = await DatabaseRoutes
        .QUESTION_DATABASES
        .where('questionId', isEqualTo: id)
        .limit(1)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return null;
    }

    final questionData = querySnapshot.docs.first.data();
    return Question.fromJson(questionData! as Map<String, dynamic>);
  }

  Future<void> saveQuestion(Question question) async {
    final docRef = DatabaseRoutes.QUESTION_DATABASES.doc();
    question.questionId =
        docRef.id; // Set questionId to the Firestore document ID
    final Map<String, dynamic> data = question.toJson();
    await docRef.set(data);
  }

  Future<List<Response>> getQuestionResponses(double questionId) async {
    final querySnapshot = await DatabaseRoutes.RENSPONSE_DATABASES
        .where('questionId', isEqualTo: questionId)
        .get();

    return querySnapshot.docs
        .map((doc) => Response.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
  Future<List<Question>> getQuestionsByType(String qT) async {
    QuerySnapshot<Object?> querySnapshots = await DatabaseRoutes.QUESTION_DATABASES.where('questionType', isEqualTo: qT).get();
    return querySnapshots.docs
        .map((doc) => Question.fromJson(doc.data()! as Map<String, dynamic>))
        .toList();
  }
}
