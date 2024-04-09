import 'package:firebase_auth/firebase_auth.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';

class AuthService implements AuthServiceInterface {
  @override
  FirebaseAuth _auth;

  AuthService(this._auth);

  static Future<void> registerUser() async {}

  @override
  bool isConnected() {
    bool result = true;
    this._auth.authStateChanges().listen((User? user) {
      if (user == null) {
        result = false;
      }
    });
    return result;
  }

  @override
  Future<UserCredential?> login(String email, String mdp) async {
    UserCredential? user = null;
    try {
      user = await _auth.signInWithEmailAndPassword(email: email, password: mdp);
      if (this.isConnected()) {
      }
    } catch (e) {
      user = null;
    }
    return user;
  }

  @override
  Future<int> logout() async {
    try {
      await this._auth.signOut();
      return 0;
    } catch (e) {
      return 1;
    }
  }

  @override
  Future<String> register(String email, String mdp, String pseudo) async {
    try {
      UserCredential user = await this._auth.createUserWithEmailAndPassword(email: email, password: mdp);
      user.user?.updateDisplayName(pseudo);
      return '';
    } on FirebaseAuthException catch(e){
      return e.code;
    }
  }
}
