import 'package:skillsprint/Models/Like.dart';

abstract class LikeServiceInterface
{
  Future<List<Like>> getAllLikes();

  Future<List<Like>> getAllLikesByUidProgramme();
}