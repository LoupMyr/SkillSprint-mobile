import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillsprint/Domain/Services/AuthServiceInterface.dart';
import 'package:skillsprint/firebase_options.dart';

class AuthService implements AuthServiceInterface {
  FirebaseAuth _auth;


  AuthService(this._auth);

  static Future<AuthService> create() async {
    WidgetsFlutterBinding.ensureInitialized();
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    );
    return AuthService(FirebaseAuth.instanceFor(app: app));
  }

  @override
  bool isConnected() {
    bool result = true;
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        result = false;
      }
    });
    return result;
  }

  @override
  Future<UserCredential?> login(String email, String mdp) async {
    UserCredential? user;
    try {
      user = await _auth.signInWithEmailAndPassword(email: email, password: mdp);
      if (isConnected()) {
      }
    } catch (e) {
      user = null;
    }
    return user;
  }

  @override
  Future<int> logout() async {
    try {
      await _auth.signOut();
      return 0;
    } catch (e) {
      return 1;
    }
  }

  @override
  Future<String> register(String email, String mdp, String pseudo) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: mdp);
      user.user?.updateDisplayName(pseudo);
      return '';
    } on FirebaseAuthException catch(e){
      return e.code;
    }
  }
}
