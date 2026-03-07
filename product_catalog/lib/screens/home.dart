import 'package:flutter/material.dart';
import 'package:product_catalog/components/products_grid_view.dart';

class Home extends StatelessWidget {
  Home({super.key});
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Text("Products"),
        backgroundColor: const Color.fromARGB(
          255,
          128,
          113,
          67,
        ),
      ),
      drawer: Drawer(
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
              accountName: Text("Unknown User"),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.arrow_back),
              title: const Text("Back"),
              onTap: () {},
            ),
          ],
        ),
      ),

      backgroundColor: const Color.fromARGB(
        255,
        174,
        172,
        160,
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ProductsGridView(),
      ),
    ));
  }
}
