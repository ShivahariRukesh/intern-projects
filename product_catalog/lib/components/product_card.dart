import 'package:flutter/material.dart';
import 'package:product_catalog/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard(this.product, {super.key});

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: Image.network(
              product.imageUrl != ''
                  ? product.imageUrl ??
                        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'
                  : 'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
            ),
          ),
          Text(product.name),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            children: [
              Text(product.price.toString()),
              Text(product.quantity.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
