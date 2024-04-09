
import 'package:skillsprint/Models/Programme.dart';

abstract class ProgrammeServiceInterface {

  Future<List<Programme>> getAllProgrammes();

  Future<List<Programme>> getProgrammesPublic();



}