import 'package:skillsprint/Models/Exercice.dart';
import 'package:skillsprint/Models/Programme.dart';

abstract class ExerciceServiceInterface
{
  Future<Exercice?> getExerciceByUid(String uid);

  Future<List<Exercice>> getExercicesInProgramme(Programme programme);
}