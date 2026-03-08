import 'package:flutter/material.dart';
import 'package:product_catalog/components/product_card.dart';
import 'package:product_catalog/models/product_model.dart';

class ProductsGridView extends StatelessWidget {
  final List<Product> products;
  ProductsGridView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      // scrollDirection: Axis.horizontal,
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
