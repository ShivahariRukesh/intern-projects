import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_with_api_sync/ui/core/shared/base_scaffold_widget.dart';
import 'package:task_manager_with_api_sync/ui/features/auth/view_model/login_view_model.dart';
// import 'package:task_manager_with_api_sync/ui/features/auth/view_model/auth_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void handleLogout() async {
      final AuthenticateViewModel vm = context
          .read<AuthenticateViewModel>();

      await vm.logoutUser();

      if (!context.mounted) return;

      if (!vm.isLoggedIn) {
        context.go('/login');
      }
    }

    return BaseScaffoldWidget(
      title: 'Profile',
      scaffoldBody: Consumer<AuthenticateViewModel>(
        builder:
            (
              BuildContext context,
              Object? authViewModel,
              Widget? child,
            ) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const CircleAvatar(
                        radius: 50,
                        child: Text(
                          'E',
                          style: TextStyle(fontSize: 32),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Guest User',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'No email provided',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                              color: Colors.grey.shade600,
                            ),
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
