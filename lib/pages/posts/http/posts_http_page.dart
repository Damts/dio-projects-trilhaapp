import 'package:flutter/material.dart';
import 'package:trilhaapp/models/posts/post_commentary_model.dart';
import 'package:trilhaapp/models/posts/post_model.dart';
import 'package:trilhaapp/pages/posts/http/comments_http_page.dart';
import 'package:trilhaapp/repositories/posts/implementation/posts_http_repository.dart';

class PostsHttpPage extends StatefulWidget {
  const PostsHttpPage({super.key});

  @override
  State<PostsHttpPage> createState() => _PostsHttpPageState();
}

class _PostsHttpPageState extends State<PostsHttpPage> {

  var postsRepository = PostsHttpRepository();
  var posts = <PostModel>[];
  var commentaries = <PostCommentaryModel>[];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    posts = await postsRepository.getPosts();
    commentaries = await postsRepository.getCommentaries(1);
    print('posts na page: $posts');
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
                Navigator.push(context, MaterialPageRoute(builder: (_) => CommentsHttpPage(postId: post.id)));
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