import 'package:flutter/material.dart';
import 'package:product_catalog/components/products_grid_view.dart';
import 'package:product_catalog/models/product_model.dart';
import 'package:product_catalog/screens/product_search.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? sortDropDownValue = 'Price';
  List<Product> productResults = products;

  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("Products"),
            SizedBox(width: 20),
            DropdownButton<String>(
              value: sortDropDownValue,
              underline: SizedBox(),
              items: ["Name", "Price", "Quantity"]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  sortDropDownValue = value;
                  productResults =
                      ProductResults.manipulateResult(
                        value!.toLowerCase(),
                      );
                });
              },
            ),
          ],
        ),
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
        child: ProductsGridView(products: productResults),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown,
        child: Icon(Icons.search, color: Colors.yellow),

        onPressed: () async {
          final searchedResult = await showSearch(
            context: context,
            delegate: ProductSearch(),
          );
          if (searchedResult != null) {
            setState(() {
              productResults = [searchedResult];
            });
          }
        },
      ),
    ));
  }
}
