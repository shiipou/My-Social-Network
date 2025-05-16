import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function(String username, String password)? onLoggedIn;

  const LoginPage({super.key, this.onLoggedIn});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'Username'),
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => onLoginPressed(context),
                          child: Text('Se connecter')),
                      ElevatedButton(
                          onPressed: () => onRegisterPressed(context),
                          child: Text('Créer un compte'))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onLoginPressed(BuildContext context) {
    if (widget.onLoggedIn == null) {
      return;
    }

    widget.onLoggedIn!(username, password);

    Navigator.pushNamed(
      context,
      '/',
    );
  }

  void onRegisterPressed(BuildContext context) {
    Navigator.pushNamed(
      context,
      '/register',
    );
  }
}
