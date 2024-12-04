import 'package:flutter/material.dart';
import 'package:newflutterapp/components/post.dart';
import 'package:newflutterapp/models/post.dart' as models;

class HomePage extends StatelessWidget {
  final List<models.Post> posts;

  const HomePage({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
    );
  }
}
