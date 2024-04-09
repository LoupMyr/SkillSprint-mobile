import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillsprint/Domain/Services/ProgrammeServiceInterface.dart';
import 'package:skillsprint/Models/Programme.dart';

class ProgrammeService implements ProgrammeServiceInterface {
  FirebaseFirestore db = FirebaseFirestore.instance;

  ProgrammeService();

  @override
  Future<List<Programme>> getAllProgrammes() async {
    List<Programme> programmes = [];
    List<String> list = [];
    await db.collection("programmes").get().then((collection) => {
      for(var doc in collection.docs){
        programmes.add(Programme.fromDocument(doc))
      }
    });
    return programmes;
  }

  @override
  Future<List<Programme>> getProgrammesPublic() {
    // TODO: implement getProgrammesPublic
    throw UnimplementedError();
  }
}
