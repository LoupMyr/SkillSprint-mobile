import 'package:cloud_firestore/cloud_firestore.dart';

class Like {
  String _uid;
  String _idUtilisateur;
  String _idProgramme;

  Like(this._uid, this._idUtilisateur, this._idProgramme);

  Like.fromDocument(QueryDocumentSnapshot doc)
      : _uid = doc.id,
        _idUtilisateur = doc.get("id_utilisateur"),
        _idProgramme = doc.get("id_programme");

  Map<String, dynamic> serialize() {
    return {
      "id_utilisateur": _idUtilisateur,
      "id_programme": _idProgramme
    };
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  String get idProgramme => _idProgramme;

  set idProgramme(String value) {
    _idProgramme = value;
  }

  String get idUtilisateur => _idUtilisateur;

  set idUtilisateur(String value) {
    _idUtilisateur = value;
  }
}
