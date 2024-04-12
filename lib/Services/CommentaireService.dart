import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skillsprint/Domain/Services/CommentaireServiceInterface.dart';
import 'package:skillsprint/Models/Commentaire.dart';
import 'package:skillsprint/Models/Programme.dart';

class CommentaireService implements CommentaireServiceInterface
{
  FirebaseFirestore db = FirebaseFirestore.instance;

  CommentaireService();

  @override
  Future<List<Commentaire>> getAllCommentaires() async {
    List<Commentaire> commentaires = [];
    await db.collection("commentaires").get().then((collection) => {
      for (QueryDocumentSnapshot doc in collection.docs)
        {commentaires.add(Commentaire.fromDocument(doc))}
    });
    return commentaires;
  }

  @override
  Future<List<Commentaire>> getCommentairesByProgrammeUid(Programme programme) async {
    List<Commentaire> result = [];
    List<Commentaire> commentaires = await getAllCommentaires();
    for(Commentaire c in commentaires){
      if(c.idProgramme == programme.uid){
        result.add(c);
      }
    }
    return result;
  }

}