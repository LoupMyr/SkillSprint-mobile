import 'package:cloud_firestore/cloud_firestore.dart';

class Commentaire
{
  String _uid;
  String _message;
  String _idProgramme;
  String _idUtilisateur;

  Commentaire(this._uid, this._message, this._idProgramme, this._idUtilisateur);

  Commentaire.fromDocument(QueryDocumentSnapshot doc):
      _uid = doc.id,
      _message = doc.get("message"),
      _idProgramme = doc.get("id_programme"),
      _idUtilisateur = doc.get("id_utilisateur");

  String get idUtilisateur => _idUtilisateur;

  set idUtilisateur(String value) {
    _idUtilisateur = value;
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