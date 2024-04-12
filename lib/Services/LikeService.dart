import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:skillsprint/Domain/Services/LikeServiceInterface.dart';
import 'package:skillsprint/Models/Like.dart';
import 'package:skillsprint/Models/Programme.dart';

class LikeService implements LikeServiceInterface {
  FirebaseFirestore db = FirebaseFirestore.instance;

  LikeService();

  @override
  Future<List<Like>> getAllLikes() async {
    List<Like> likes = [];
    await db.collection("likes").get().then((collection) => {
          for (QueryDocumentSnapshot doc in collection.docs)
            {likes.add(Like.fromDocument(doc))}
        });
    return likes;
  }

  @override
  Future<List<Like>> getLikesByProgrammeUid(Programme programme) async {
    List<Like> result = [];
    List<Like> likes = await getAllLikes();
    for (Like l in likes) {
      if (programme.uid == l.idProgramme) {
        result.add(l);
      }
    }
    return result;
  }

  @override
  Future<bool> hasLiked(Programme programme) async {
    bool result = false;
    List<Like> likesOfProgramme = await getLikesByProgrammeUid(programme);
    if (likesOfProgramme.isNotEmpty) {
      for (Like like in likesOfProgramme) {
        if (like.idUtilisateur == FirebaseAuth.instance.currentUser!.uid) {
          result = true;
        }
      }
    }
    return result;
  }

  @override
  Future<List<Like>> getLikesByUserUid() async {
    List<Like> result = [];
    List<Like> likes = await getAllLikes();
    for (Like l in likes) {
      if (FirebaseAuth.instance.currentUser!.uid == l.idUtilisateur) {
        result.add(l);
      }
    }
    return result;
  }

  @override
  Future<void> postLike(Like like) async {
    try {
      await db.collection("likes").add(like.serialize());
    } catch (e) {
      debugPrint('Erreur lors de l\'ajout du like : $e');
    }
  }

  @override
  Future<void> deleteLike(Programme programme) async {
    try {
      String uid = await _findUidLikeByUidUserAndUidProgramme(programme);
      await db.collection("likes").doc(uid).delete();
    } catch (e) {
      print("Erreur lors de la suppression du like : $e");
    }
  }

  Future<String> _findUidLikeByUidUserAndUidProgramme(
      Programme programme) async {
    List<Like> likes = await getLikesByProgrammeUid(programme);
    String uid = "";
    for (Like like in likes) {
      if (like.idProgramme == programme.uid &&
          like.idUtilisateur == FirebaseAuth.instance.currentUser!.uid) {
        uid = like.uid;
      }
    }
    return uid;
  }
}
