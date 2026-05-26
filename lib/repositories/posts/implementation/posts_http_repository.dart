import 'dart:convert';
import 'package:trilhaapp/models/posts/post_model.dart';
import 'package:http/http.dart' as http;
import 'package:trilhaapp/models/posts/post_commentary_model.dart';
import 'package:trilhaapp/repositories/posts/posts_repository.dart';

class PostsHttpRepository implements PostsRepository {
  @override
  Future<List<PostModel>> getPosts () async {
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    print('Status code HTTP posts: ${response.statusCode}');
    if (response.statusCode == 200) {
      var jsonPosts = jsonDecode(response.body);
      return (jsonPosts as List).map((post) => PostModel.fromJson(post)).toList();
    }
    return [];
  }

  @override
  Future<PostModel> getPost(int postId) async {
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId"));
    if (response.statusCode == 200) {
      var jsonPost = jsonDecode(response.body);
      return PostModel.fromJson(jsonPost);
    }
    return PostModel.vazio();
  }
  
  @override
  Future<List<PostCommentaryModel>> getCommentaries (int postId) async {
    var response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts/$postId/comments"));
    print('Status code HTTP commentaries: ${response.statusCode}');
    if (response.statusCode == 200) {
      var jsonComments = jsonDecode(response.body);
      return (jsonComments as List).map((comment) => PostCommentaryModel.fromJson(comment)).toList();
    }
    return [];
  }
}