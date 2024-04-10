import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServiceInterface {
  Future<String> register(String email, String mdp, String pseudo);

  Future<UserCredential?> login(String email, String mdp);

  Future<int> logout();

  bool isConnected();

}