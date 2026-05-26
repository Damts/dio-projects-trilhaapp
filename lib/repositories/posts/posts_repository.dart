import 'package:trilhaapp/models/posts/post_commentary_model.dart';
import 'package:trilhaapp/models/posts/post_model.dart';

abstract class PostsRepository {
  Future<List<PostModel>> getPosts ();

  Future<PostModel> getPost(int postId);
  
  Future<List<PostCommentaryModel>> getCommentaries (int postId);
}