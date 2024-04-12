import 'package:skillsprint/Models/Commentaire.dart';

abstract class CommentaireServiceInterface
{
  Future<List<Commentaire>> getAllCommentaires();

  Future<List<Commentaire>> getCommentairesByProgrammeUid();
}