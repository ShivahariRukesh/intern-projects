import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_with_api_sync/ui/core/shared/base_scaffold_widget.dart';
import 'package:task_manager_with_api_sync/ui/features/auth/view_model/login_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticateViewModel vm = context
        .read<AuthenticateViewModel>();

    void handleLogout() async {
      await vm.logoutUser();

      if (!context.mounted) {
        return;
      }
      context.go('/login');
    }

    return BaseScaffoldWidget(
      title: 'Profile',
      scaffoldBody: Consumer<AuthenticateViewModel>(
        builder:
            (
              BuildContext context,
              AuthenticateViewModel? authViewModel,
              Widget? child,
            ) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50,
                        child: Text(
                          authViewModel?.usernameState
                                  ?.substring(0, 1) ??
                              'G',
                          style: const TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        authViewModel?.usernameState ??
                            'Guest User',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        authViewModel?.emailState ??
                            'No emailState provided',
                      ),

                      OutlinedButton(
                        onPressed: () => handleLogout(),
                        child: const Text('Log out'),
                      ),
                    ],
                  ),
                ),
              );
            },
      ),
    );
  }
}
