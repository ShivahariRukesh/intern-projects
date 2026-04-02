import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager_with_api_sync/ui/core/shared/base_scaffold_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'Login',
      scaffoldBody: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),

        child: Column(
          children: <Widget>[
            const Text('Login'),
            const Text('Username'),
            const Text('Password'),
            OutlinedButton(
              onPressed: () => context.go('/'),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
