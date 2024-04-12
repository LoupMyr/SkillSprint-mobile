import 'package:skillsprint/Models/Like.dart';
import 'package:skillsprint/Models/Programme.dart';

abstract class LikeServiceInterface {
  Future<List<Like>> getAllLikes();

  Future<List<Like>> getLikesByProgrammeUid(Programme programme);

  Future<bool> hasLiked(Programme programme);

  Future<List<Like>> getLikesByUserUid();

  Future<void> postLike(Like like);

  Future<void> deleteLike(Programme programme);

}
