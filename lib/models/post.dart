import 'package:flutter/cupertino.dart';
import 'package:newflutterapp/models/user.dart';

class Post {
  User owner;
  String? content;
  String? image;
  Post? embededPost;
  List<Post> comments;
  List<User> likes;

  Post({
    required this.owner,
    this.content,
    this.image,
    this.embededPost,
    this.comments = const [],
    this.likes = const [],
  });
}

class PostProvider extends InheritedWidget {
  final List<Post> posts;
  final Function setPosts;

  PostProvider({
    required this.posts,
    required this.setPosts,
    required super.child,
    super.key,
  });

  @override
  bool updateShouldNotify(covariant PostProvider oldWidget) {
    return posts != oldWidget.posts;
  }

  static PostProvider? ofMaybe(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<PostProvider>();
  static PostProvider of(BuildContext context) => ofMaybe(context)!;

  void addPost(Post post) {
    setPosts([post, ...posts]);
  }

  void removePost(Post post) {
    List<Post> newPostList =
        posts.where((postElement) => postElement != post).toList();
    setPosts(newPostList);
  }

  void updatePost(Post post) {
    List<Post> newPostList = posts
        .map((postElement) => postElement == post ? post : postElement)
        .toList();
    setPosts(newPostList);
  }
}
