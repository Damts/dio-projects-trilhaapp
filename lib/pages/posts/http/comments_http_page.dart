import 'package:flutter/material.dart';
import 'package:trilhaapp/models/posts/post_commentary_model.dart';
import 'package:trilhaapp/models/posts/post_model.dart';
import 'package:trilhaapp/repositories/posts/implementation/posts_http_repository.dart';

class CommentsHttpPage extends StatefulWidget {
  final int postId;
  const CommentsHttpPage({super.key, required this.postId});

  @override
  State<CommentsHttpPage> createState() => _CommentsHttpPageState();
}

class _CommentsHttpPageState extends State<CommentsHttpPage> {

  var postsRepository = PostsHttpRepository();
  PostModel? post;
  var comments = <PostCommentaryModel>[];

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    carregarDadosPost();
  }

  void carregarDadosPost() async {
    setState(() {
      isLoading = true;
    });

    post = await postsRepository.getPost(widget.postId);
    comments = await postsRepository.getCommentaries(widget.postId);

    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: post != null ? Text("Comentarios do post ${post!.title} ") : Text('Comentarios'),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: isLoading 
            ? Center(child: CircularProgressIndicator()) 
            : ListView.builder(
                itemCount: comments.length,
                itemBuilder: (_, index) {
                  var comment = comments[index];
                  return Card(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                comment.name.substring(0, 10),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                comment.email,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(comment.body),
                        ],
                      ),
                    ),
                  );
                },
            ),
        ),
      ),
    );
  }
}