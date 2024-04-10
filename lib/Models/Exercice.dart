import 'package:cloud_firestore/cloud_firestore.dart';

class Exercice {
  String _uid;
  String _nom;
  int _nbSerie;
  int _nbRep;

  Exercice(this._uid, this._nom, this._nbSerie, this._nbRep);

  Exercice.fromDocument(QueryDocumentSnapshot doc)
      : _uid = doc.id,
        _nom = doc.get("nom"),
        _nbSerie = doc.get("nbSerie"),
        _nbRep = doc.get("nbRep");

  Map<String, dynamic> serialize() {
    return {
      "nom": _nom,
      "nbSerie": _nbSerie,
      "nbRep": _nbRep,
    };
  }

  int get nbRep => _nbRep;

  set nbRep(int value) {
    _nbRep = value;
  }

  int get nbSerie => _nbSerie;

  set nbSerie(int value) {
    _nbSerie = value;
  }

  String get uid => _uid;

  set uid(String value) {
    _uid = value;
  }

  String get nom => _nom;

  set nom(String value) {
    _nom = value;
  }
}
