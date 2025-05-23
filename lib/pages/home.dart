import 'package:flutter/material.dart';
import 'package:newflutterapp/components/post.dart';
import 'package:newflutterapp/models/post.dart' as models;
import 'package:newflutterapp/models/user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = UserProvider.of(context);
    final User? user = userProvider.user;
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => Navigator.pushNamed(context, "/login"),
      );
    }

    final models.PostProvider postProvider = models.PostProvider.of(context);
    final List<models.Post> posts = postProvider.posts;

    return Scaffold(
      appBar: AppBar(
        title: Text('User : ${user?.username}'),
        actions: [
          IconButton(
            icon: Icon(user != null ? Icons.logout : Icons.login),
            onPressed: () {
              userProvider.logout();
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
