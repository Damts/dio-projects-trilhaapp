import 'package:flutter/material.dart';
import 'package:trilhaapp/models/posts/post_model.dart';
import 'package:trilhaapp/models/posts/post_commentary_model.dart';
import 'package:trilhaapp/repositories/jsonplaceholder_custom_dio.dart';
import 'package:trilhaapp/repositories/posts/posts_repository.dart';

class PostsDioRepository implements PostsRepository {
  @override
  Future<List<PostCommentaryModel>> getCommentaries(int postId) async {
    var jsonplaceholderCustomDio = JsonplaceholderCustomDio();
    var response = await jsonplaceholderCustomDio.dio.get("/posts/$postId/comments");
    debugPrint('Status code DIO: ${response.statusCode}');
    if (response.statusCode == 200) {
      return (response.data as List).map((comment) => PostCommentaryModel.fromJson(comment)).toList();
    }
    return [];
  }

  @override
  Future<PostModel> getPost(int postId) async {
    var jsonplaceholderCustomDio = JsonplaceholderCustomDio();
    var response = await jsonplaceholderCustomDio.dio.get("/posts/$postId");
    debugPrint('Status code DIO: ${response.statusCode}');
    if (response.statusCode == 200) {
      return PostModel.fromJson(response.data);
    }
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getPosts() async {
    var jsonplaceholderCustomDio = JsonplaceholderCustomDio();
    var response = await jsonplaceholderCustomDio.dio.get("/posts");
    debugPrint('Status code DIO: ${response.statusCode}');
    if (response.statusCode == 200) {
      return (response.data as List).map((post) => PostModel.fromJson(post)).toList();
    }
    return [];
  }

}