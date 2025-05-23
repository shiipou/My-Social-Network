import 'package:flutter/material.dart';

class User {
  String username;
  String? password;
  String avatar;
  String? token;

  User({
    required this.username,
    this.password,
    this.avatar = 'https://placehold.co/150',
    this.token,
  });
}

class UserProvider extends InheritedWidget {
  final User? user;
  final Function(User) setUser;
  final Function() logout;

  const UserProvider({
    super.key,
    required this.user,
    required this.setUser,
    required this.logout,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant UserProvider oldWidget) {
    return user != oldWidget.user;
  }

  static UserProvider? ofMaybe(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>();
  }

  static UserProvider of(BuildContext context) {
    return ofMaybe(context)!;
  }
}
