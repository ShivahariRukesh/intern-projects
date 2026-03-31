import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.black45,
      ),
      child: const Column(
        children: <Widget>[
          Text('Login'),
          Text('Username'),
          Text('Password'),
        ],
      ),
    );
  }
}
