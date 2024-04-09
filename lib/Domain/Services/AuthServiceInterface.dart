import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServiceInterface {
  late FirebaseAuth _auth;

  Future<String> register(String email, String mdp, String pseudo);

  Future<UserCredential?> login(String email, String mdp);

  Future<int> logout();

  bool isConnected();

}