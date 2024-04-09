import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillsprint/Domain/Services/ProgrammeServiceInterface.dart';
import 'package:skillsprint/Models/Programme.dart';

class ProgrammeService implements ProgrammeServiceInterface {
  FirebaseFirestore db = FirebaseFirestore.instance;

  ProgrammeService();

  Future<List<Programme>> getAllProgrammes() async {
    List<Programme> programmes = [];
    await db.collection("programmes").get().then((collection) => {
          for (var doc in collection.docs)
            {programmes.add(Programme.fromDocument(doc))}
        });
    return programmes;
  }

  Future<void> PostProgrammes(Programme programme) async {
    final progr = <String, dynamic>{
      "estPublic": "Ada",
      "id_utilisateur": "Lovelace",
      "nom": 1815,
      "rep": 1815
    };

    this
        .db
        .collection("programmes")
        .add(progr)
        .then((value) => print("Add successfull"));
  }

  @override
  Future<List<Programme>> getProgrammesPublic() {
    // TODO: implement getProgrammesPublic
    throw UnimplementedError();
  }
}
