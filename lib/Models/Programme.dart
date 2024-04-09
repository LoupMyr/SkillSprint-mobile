import 'package:cloud_firestore/cloud_firestore.dart';

class Programme {
  String _uid;
  String _nom;
  int _rep;
  int _serie;
  bool _estPublic;
  String _id_utilisateur;

  Programme(this._uid, this._nom, this._rep, this._serie, this._estPublic,
      this._id_utilisateur);

  Programme.fromDocument(QueryDocumentSnapshot doc)
      : _uid = doc.id,
        _nom = doc.get("nom"),
        _rep = doc.get("rep"),
        _serie = doc.get("serie"),
        _estPublic = doc.get("estPublic"),
        _id_utilisateur = doc.get("id_utilisateur");

  Map<String, dynamic> serialize() {
    return {
      "uid": _uid,
      "nom": _nom,
      "rep": _rep,
      "serie": _serie,
      "estPublic": _estPublic,
      "id_utilisateur": _id_utilisateur
    };
  }

  bool get estPublic => _estPublic;

  set estPublic(bool value) {
    _estPublic = value;
  }

  int get serie => _serie;

  set serie(int value) {
    _serie = value;
  }

  int get rep => _rep;

  set rep(int value) {
    _rep = value;
  }

  String get nom => _nom;

  set nom(String value) {
    _nom = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  String get id_utilisateur => _id_utilisateur;

  set id_utilisateur(String value) {
    _id_utilisateur = value;
  }
}
