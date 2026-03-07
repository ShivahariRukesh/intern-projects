import 'package:flutter/material.dart';
import 'package:product_catalog/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard(this.product, {super.key});

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(child: Text("${product.name}")),
    );
  }
}
