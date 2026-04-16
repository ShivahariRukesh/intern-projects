import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_with_api_sync/ui/core/shared/base_scaffold_widget.dart';
import 'package:task_manager_with_api_sync/ui/features/auth/view_model/login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController =
      TextEditingController();
  final TextEditingController _passwordController =
      TextEditingController();

  // Local state for error messages
  String? _usernameError;
  String? _passwordError;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void handleLogin() async {
    setState(() {
      _usernameError = _validateUsername(
        _usernameController.text,
      );
      _passwordError = _validatePassword(
        _passwordController.text,
      );
    });

    if (_usernameError == null && _passwordError == null) {
      final AuthenticateViewModel vm = context
          .read<AuthenticateViewModel>();

      await vm.loginUser(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      if (vm.isLoggedIn) {
        context.go('/task');
      }
    }
  }

  String? _validateUsername(String value) {
    if (value.isEmpty) return 'Username cannot be empty';
    if (value.length < 3) return 'Too short';
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) return 'Password cannot be empty';
    if (value.length < 6) {
      return 'Password must be 6+ characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffoldWidget(
      title: 'Login',
      scaffoldBody: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.stretch,
              children: <Widget>[
                // ... (Icon and Welcome Text remain the same)
                const SizedBox(height: 40),

                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(
                      Icons.person_outline,
                    ),
                    filled: true,
                    // 3. Manually pass the error text
                    errorText: _usernameError,
                  ),
                  // Optional: clear error while typing
                  onChanged: (_) =>
                      setState(() => _usernameError = null),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                    ),
                    filled: true,
                    // 4. Manually pass the error text
                    errorText: _passwordError,
                  ),
                  onChanged: (_) =>
                      setState(() => _passwordError = null),
                ),

                const SizedBox(height: 32),

                FilledButton(
                  onPressed: handleLogin,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
