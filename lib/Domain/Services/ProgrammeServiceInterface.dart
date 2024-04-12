
import 'package:skillsprint/Models/Like.dart';
import 'package:skillsprint/Models/Programme.dart';

abstract class ProgrammeServiceInterface {

  Future<List<Programme>> getAllProgrammes();

  Future<void> postProgrammes(Map<String, dynamic> programme);

  Future<List<Programme>> getProgrammesPublic();

  Future<List<Programme>> getProgrammesByUidUser(String uidUser);

  Future<List<Programme>> getProgrammesByLikes(List<Like> likes);
}