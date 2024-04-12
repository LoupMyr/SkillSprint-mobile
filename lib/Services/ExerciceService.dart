import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillsprint/Domain/Services/ExerciceServiceInterface.dart';
import 'package:skillsprint/Models/Exercice.dart';
import 'package:skillsprint/Models/Programme.dart';

class ExerciceService implements ExerciceServiceInterface {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<Exercice?> getExerciceByUid(String uid) async {
    Exercice? exercice;
    await db.collection("exercice").get().then((collection) => {
          for (var doc in collection.docs)
            {
              if (doc.id == uid) {exercice = Exercice.fromDocument(doc)}
            }
        });
    return exercice;
  }

  @override
  Future<List<Exercice>> getExercicesInProgramme(Programme programme) async {
    List<Exercice> result = [];
    for (String uidExo in programme.idExercices) {
      Exercice? exo = await getExerciceByUid(uidExo);
      if (exo != null) {
        result.add(exo);
      }
    }
    return result;
  }

  static String generateUID() {
    return FirebaseFirestore.instance.collection('exercice').doc().id;
  }

  Future<void> addExercices(Map<String, dynamic> exercice, String id) async {
    try {
      await db.collection('exercice').doc(id).set(exercice);
    } catch (e) {
      debugPrint('Erreur lors de l\'ajout du post : $e');
    }
  }
}
