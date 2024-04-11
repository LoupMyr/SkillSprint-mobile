import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillsprint/Domain/Services/ProgrammeServiceInterface.dart';
import 'package:skillsprint/Models/Programme.dart';

class ProgrammeService implements ProgrammeServiceInterface {
  FirebaseFirestore db = FirebaseFirestore.instance;

  ProgrammeService();

  @override
  Future<List<Programme>> getAllProgrammes() async {
    List<Programme> programmes = [];
    await db.collection("programmes").get().then((collection) => {
          for (var doc in collection.docs)
            {programmes.add(Programme.fromDocument(doc))}
        });
    return programmes;
  }

  Future<void> postProgrammes(Map<String, dynamic> programme) async {
    try {
      // Accéder à la collection "posts"
      await db.collection("programmes").add(programme);
      // Ajouter un nouveau document avec les données du post
      print('Post ajouté avec succès');
    } catch (e) {
      print('Erreur lors de l\'ajout du post : $e');
    }
  }

  @override
  Future<List<Programme>> getProgrammesPublic() async {
    List<Programme> programmes = await getAllProgrammes();
    List<Programme> result = [];
    for (Programme p in programmes) {
      if (p.estPublic) {
        result.add(p);
      }
    }
    return result;
  }

  @override
  Future<List<Programme>> getProgrammesByUidUser(String uidUser) async {
    List<Programme> programmes = await getAllProgrammes();
    List<Programme> result = [];
    for (Programme p in programmes) {
      if (p.id_utilisateur == uidUser) {
        result.add(p);
      }
    }
    return result;
  }
}
