import 'package:flutter/material.dart';

class ProductDrawer extends StatelessWidget {
  const ProductDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(
        255,
        128,
        113,
        67,
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 174, 172, 160),
            ),
            accountName: Text(
              "Customer",
              style: TextStyle(color: Colors.black),
            ),
            accountEmail: Text(""),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),

          ListTile(
            leading: Icon(Icons.arrow_left),
            title: const Text("Go Back"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
