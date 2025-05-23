import 'package:flutter/material.dart';
import 'package:newflutterapp/models/user.dart';
import 'package:newflutterapp/services/miniature_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
          constraints: const BoxConstraints(maxWidth: 500),
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
                          child: const Text('Se connecter')),
                      ElevatedButton(
                          onPressed: () => onRegisterPressed(context),
                          child: const Text('Créer un compte'))
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

  void onLoginPressed(BuildContext context) async {
    final UserProvider userProvider = UserProvider.of(context);

    User user = await MiniatureApiService.login(username, password);

    userProvider.setUser(user);

    if (context.mounted) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, '/');
      }
    }
  }

  void onRegisterPressed(BuildContext context) {
    Navigator.pushReplacementNamed(
      context,
      '/register',
    );
  }
}
