import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillsprint/Domain/Services/CommentaireServiceInterface.dart';
import 'package:skillsprint/Models/Commentaire.dart';

class CommentaireService implements CommentaireServiceInterface
{
  FirebaseFirestore db = FirebaseFirestore.instance;

  CommentaireService();

  @override
  Future<List<Commentaire>> getAllCommentaires() {
    // TODO: implement getAllCommentaires
    throw UnimplementedError();
  }

  @override
  Future<List<Commentaire>> getCommentairesByProgrammeUid() {
    // TODO: implement getCommentairesByProgrammeId
    throw UnimplementedError();
  }

}