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

  static Programme fromDocument(QueryDocumentSnapshot doc) {
    List<String> ids = [];
    for(String exo in doc.get("exercices")){
      ids.add(exo.toString());
    }
    return Programme(doc.id, doc.get("nom"),doc.get("estPublic"), ids, doc.get("id_utilisateur"));
  }

  Map<String, dynamic> serialize() {
    return {
      "uid": _uid,
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
