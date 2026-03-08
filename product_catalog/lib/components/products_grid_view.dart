import 'package:flutter/material.dart';
import 'package:product_catalog/components/product_card.dart';
import 'package:product_catalog/models/product_model.dart';

class ProductsGridView extends StatelessWidget {
  ProductsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,

      children: products
          .map((Product product) => ProductCard(product))
          .toList(),
      // children: List<Widget>.generate(
      //   10,
      //   (int index) => ProductCard(),
      // ).toList(),
    );
  }
}
