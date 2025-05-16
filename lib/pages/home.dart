import 'package:flutter/material.dart';
import 'package:newflutterapp/components/post.dart';
import 'package:newflutterapp/models/post.dart' as models;
import 'package:newflutterapp/models/user.dart';

class HomePage extends StatelessWidget {
  final List<models.Post> posts;
  final User? user;

  const HomePage({super.key, required this.posts, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User : ${user?.username}'),
        actions: [
          IconButton(
            icon: Icon(user != null ? Icons.logout : Icons.login),
            onPressed: () {
              Navigator.pushNamed(context, user != null ? "/logout" : "/login");
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          models.Post post = posts[index];

          return Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Post(
              post: post,
              shareCount:
                  posts.where((aPost) => aPost.embededPost == post).length,
            ),
          );
        },
      ),
    );
  }
}
