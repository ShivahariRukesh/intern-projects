import 'package:flutter/material.dart';
import 'package:social_media_app/models/user_model.dart';

class DrawerWidget extends StatelessWidget {
  final UserModel? loggedInUser;
  const DrawerWidget({super.key, this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(loggedInUser?.username ?? 'Guest User'),
            accountEmail: Text(loggedInUser?.email ?? 'guest@email.com'),
            currentAccountPicture: const CircleAvatar(
                // backgroundImage: NetworkImage(
                //     viewModel.userAvatarUrl ??
                //         'https://via.placeholder.com/150',
                //     ),
                ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          const ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
