import 'package:firebase_auth/firebase_auth.dart';
import 'package:skillsprint/Domain/Services/UserServiceInterface.dart';

class UserService implements UserServiceInterface {

  @override
  Future<List<String>> updateDisplayName(String newName) async {
    User? user = FirebaseAuth.instance.currentUser;
    String str = "Profil mis à jour avec succès";
    String err = "success";
    try {
      await user!.updateDisplayName(newName);
    } catch (e) {
      str = "Erreur lors de la mise à jour du profil";
      err = "error";
    }
    return [str, err];
  }
}
