import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newflutterapp/models/user.dart';
import 'package:newflutterapp/models/post.dart';
import 'package:newflutterapp/pages/home.dart';
import 'package:newflutterapp/pages/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Post> posts = [];

  User? loggedUser;

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return UserProvider(
      user: loggedUser,
      setUser: onLoggedIn,
      logout: onLoggedOut,
      child: PostProvider(
        posts: posts,
        setPosts: onUpdatedPosts,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Fundamentals',
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/login': (context) => const LoginPage(),
          },
        ),
      ),
    );
  }

  void onUpdatedPosts(List<Post> posts) {
    setState(() {
      this.posts = posts;
    });
  }

  void onLoggedIn(User user) {
    setState(() {
      loggedUser = user;
    });
  }

  void onLoggedOut() {
    setState(() {
      loggedUser = null;
    });
  }
}
