import 'package:flutter/material.dart';
import 'package:trilhaapp/models/posts/post_commentary_model.dart';
import 'package:trilhaapp/models/posts/post_model.dart';
import 'package:trilhaapp/pages/posts/dio/comments_dio_page.dart';
import 'package:trilhaapp/repositories/posts/implementation/post_dio_repository.dart';
import 'package:trilhaapp/repositories/posts/posts_repository.dart';

class PostsDioPage extends StatefulWidget {
  const PostsDioPage({super.key});

  @override
  State<PostsDioPage> createState() => _PostsDioPageState();
}

class _PostsDioPageState extends State<PostsDioPage> {

  late PostsRepository postsRepository;
  var posts = <PostModel>[];
  var commentaries = <PostCommentaryModel>[];

  @override
  void initState() {
    super.initState();
    postsRepository = PostsDioRepository();
    carregarDados();
  }

  void carregarDados() async {
    posts = await postsRepository.getPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue, 
          title: Text('Posts via API'),
        ),
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (_, index) {
            var post = posts[index];
            return InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => CommentsDioPage(postId: post.id)));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          post.body ?? "",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}