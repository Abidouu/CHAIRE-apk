import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<String, String>> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
        String idToken = await user.getIdToken() ?? '';
        print('User ID token: $idToken');
        return {'status': 'connected', 'token': idToken};
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return {'status': 'forbidden', 'msg': 'No user found for that email.'};
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return {
          'status': 'forbidden',
          'msg': 'Wrong password provided for that user.'
        };
      }
    }
    // Return forbidden status and a generic error message when the server is inaccessible
    return {'status': 'forbidden', 'msg': 'The server is currently inaccessible'};
  }


  Future<String?> getConnectedUserId() async {
    User? currentUser = auth.currentUser;

    if (currentUser == null) {
      return null; // No user is currently authenticated
    }

    return currentUser.uid;
  }

}
