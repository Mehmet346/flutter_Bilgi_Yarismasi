import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  //Referans
  final _ref = FirebaseAuth.instance;

  //Giriş yap
  Future<String> login(String email, String password) async {
    String res = 'error';

    try {
      await _ref.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
