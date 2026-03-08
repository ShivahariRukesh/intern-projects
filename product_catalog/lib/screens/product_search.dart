import 'package:flutter/material.dart';
import 'package:product_catalog/models/product_model.dart';

class ProductSearch extends SearchDelegate {
  var searchText = TextEditingController();
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.notification_add_outlined),
          title: Text(products[index].name),
          trailing: Icon(Icons.next_plan_outlined),
          onTap: () => debugPrint(products[index].name),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Product> searchedResult = query != ''
        ? products
              .where(
                (product) => product.name
                    .toLowerCase()
                    .contains(query.toLowerCase()),
              )
              .toList()
        : [];
    return ListView.builder(
      itemCount: searchedResult.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchedResult[index].name),
          trailing: Icon(Icons.next_plan),
          onTap: () => debugPrint(
            "Result is clicked ${searchedResult[index].name}",
          ),
        );
      },
    );
  }
}
