import 'package:cci_app/models/user.dart';
import 'package:cci_app/utils/database_roots.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  Future<List<User>> getAllUsers() async {
    final QuerySnapshot<Object?> querySnapshot =
        await DatabaseRoutes.USER_DATABASES.get();

    return querySnapshot.docs
        .map((doc) => User.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<User?> getUserById(String id) async {
    final userRef = DatabaseRoutes.USER_DATABASES.doc(id);
    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      final userData = userSnapshot.data() as Map<String, dynamic>;
      return User.fromJson(userData);
    } else {
      return null;
    }
  }

  Future<void> saveUser(User user) async {
    try {
      final Map<String, dynamic> userData = user.toJson();
      await DatabaseRoutes.USER_DATABASES.doc().set(userData);
    } catch (e) {
      print('Error saving user: $e');
    }
  }
}
