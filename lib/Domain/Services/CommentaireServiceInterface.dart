import 'package:skillsprint/Models/Commentaire.dart';
import 'package:skillsprint/Models/Programme.dart';

abstract class CommentaireServiceInterface
{
  Future<List<Commentaire>> getAllCommentaires();

  Future<List<Commentaire>> getCommentairesByProgrammeUid(Programme programme);
}