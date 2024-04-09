
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Programme {
  String _uid;
  String _nom;
  bool _estPublic;
  List<String> _idExercices;
  String _id_utilisateur;

  Programme(this._uid, this._nom, this._estPublic, this._idExercices,
      this._id_utilisateur);

  Programme.fromDocument(QueryDocumentSnapshot doc)
      : _uid = doc.id,
        _nom = doc.get("nom"),
        _estPublic = doc.get("estPublic"),
        _idExercices = List.from(doc.get("exercices")),
        _id_utilisateur = doc.get("id_utilisateur");


  Map<String, dynamic> serialize() {
    return {
      "nom": _nom,
      "exercice": _idExercices,
      "estPublic": _estPublic,
      "id_utilisateur": _id_utilisateur
    };
  }

  bool get estPublic => _estPublic;

  set estPublic(bool value) {
    _estPublic = value;
  }

  List<String> get idExercices => _idExercices;

  set idExercices(List<String> value) {
    _idExercices = value;
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
