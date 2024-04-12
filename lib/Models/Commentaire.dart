import 'package:cloud_firestore/cloud_firestore.dart';

class Commentaire {
  String _uid;
  String _nameSender;
  String _message;
  String _idProgramme;
  String _idUtilisateur;

  Commentaire(this._uid, this._nameSender, this._message, this._idProgramme,
      this._idUtilisateur);

  Commentaire.fromDocument(QueryDocumentSnapshot doc)
      : _uid = doc.id,
        _nameSender = doc.get("NameSender"),
        _message = doc.get("Message"),
        _idProgramme = doc.get("id_programmes"),
        _idUtilisateur = doc.get("id_utilisateur");

  Map<String, dynamic> serialize() {
    return {
      "NameSender": _nameSender,
      "Message": _message,
      "id_programmes": _idProgramme,
      "id_utilisateur": _idUtilisateur
    };
  }

  String get idUtilisateur => _idUtilisateur;

  set idUtilisateur(String value) {
    _idUtilisateur = value;
  }

  String get nameSender => _nameSender;

  set nameSender(String value) {
    _nameSender = value;
  }

  String get idProgramme => _idProgramme;

  set idProgramme(String value) {
    _idProgramme = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }
}
