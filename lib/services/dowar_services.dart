

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/dowar.dart';
import '../utils/database_roots.dart';

class DowarService {

  Future<void> saveDowar(Dowar dowar) async {
    try {
      final Map<String, dynamic> dowarData = dowar.toJson();
      await DatabaseRoutes.DOWAR_DATABASES.doc().set(dowarData);
    } catch (e) {
      print('Error saving dowar: $e');
    }
  }

  

  Future<List<Dowar>> getAllDowar() async {
    final QuerySnapshot<Object?> querySnapshot =
        await DatabaseRoutes.DOWAR_DATABASES.get();
    return querySnapshot.docs
        .map((doc) => Dowar.fromJson(doc.data() as Map<String, dynamic>))
        .toList();

  }

  Future<Dowar?> getDowarById(String id) async {
    final dowarRef = DatabaseRoutes.DOWAR_DATABASES.doc(id);
    final dowarSnapshot = await dowarRef.get();
    if (dowarSnapshot.exists) {
      final dowarData = dowarSnapshot.data() as Map<String, dynamic>;
      return Dowar.fromJson(dowarData);
    } else {
      return null;
    }
  }

  Future<String> retrieveDowarID(String intID) async {

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('dowars')
        .where('intervalId', isEqualTo: intID)
        .limit(1)
        .get();

    String dowarID = snapshot.docs.first['douwarId'] as String;
    return dowarID;
  }

  Future<String> retrieveDowarname(String intID) async {

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('dowars')
        .where('intervalId', isEqualTo: intID)
        .limit(1)
        .get();

    String dowarname = snapshot.docs.first['dowarName'] as String;
    return dowarname;
  }


}
