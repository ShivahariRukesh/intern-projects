// import 'package:flutter/widgets.dart';
abstract class Searchable {
  List<Product> searchProducts(String name);
}

abstract class Sortable {
  List<Product> sortProducts(
    List<Product> products, [
    bool isAscending,
  ]);
}

class NameSearch implements Searchable {
  @override
  List<Product> searchProducts(String productName) {
    List<Product> searchedResult = productName != ''
        ? products
              .where(
                (product) => product.name
                    .toLowerCase()
                    .contains(productName.toLowerCase()),
              )
              .toList()
        : [];

    return searchedResult;
  }
}

class PriceSort implements Sortable {
  @override
  List<Product> sortProducts(
    List<Product> products, [
    isAscending = true,
  ]) {
    products.sort(
      (a, b) => isAscending
          ? a.price.compareTo(b.price)
          : b.price.compareTo(a.price),
    );

    return products;
  }
}

class QuantitySort implements Sortable {
  @override
  List<Product> sortProducts(
    List<Product> products, [
    isAscending = true,
  ]) {
    products.sort(
      (a, b) => isAscending
          ? a.quantity - b.quantity
          : b.quantity - a.quantity,
    );

    return products;
  }
}

class NameSort implements Sortable {
  @override
  List<Product> sortProducts(
    List<Product> products, [
    isAscending = true,
  ]) {
    products.sort(
      (a, b) => isAscending
          ? a.name.compareTo(b.name)
          : b.name.compareTo(a.name),
    );

    return products;
  }
}

abstract class Product {
  final String? imageUrl;
  final String name;
  final double price;
  final int quantity;

  Product({
    this.imageUrl,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  String toString() {
    return " Name : $name , Price : $price , Quantity : $quantity";
  }

  void display() {
    print("$name : $price");
  }

  void displayProductType();
}

class Instrument extends Product {
  Instrument({
    super.imageUrl,
    required super.name,
    required super.price,
    required super.quantity,
  });

  @override
  void displayProductType() {
    print("Soulful Instrument");
  }
}

class Mobile extends Product {
  Mobile({
    super.imageUrl,
    required super.name,
    required super.price,
    required super.quantity,
  });

  @override
  void displayProductType() {
    print("Mobile Accessories");
  }
}

List<Product> products = [
  Instrument(
    imageUrl:
        'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
    name: 'Guitar',
    price: 5000,
    quantity: 2,
  ),
  Instrument(
    imageUrl: '',
    name: 'Keyboard',
    price: 9000,
    quantity: 5,
  ),
  Instrument(
    imageUrl: '',
    name: 'Violin',
    price: 3000,
    quantity: 2,
  ),

  Mobile(
    imageUrl: '',
    name: 'Iphone 15',
    price: 45000,
    quantity: 3,
  ),
  Mobile(
    imageUrl: '',
    name: 'Iphone 17',
    price: 65000,
    quantity: 4,
  ),
  Mobile(
    imageUrl: '',
    name: 'Samsung',
    price: 30000,
    quantity: 8,
  ),
];

// void main() {
class ProductResults {
  static List<Product> manipulateResult(String type) {
    switch (type) {
      case "name":
        return NameSort().sortProducts(products);
      case "price":
        return PriceSort().sortProducts(products);

      case "quantity":
        return QuantitySort().sortProducts(products);
      default:
        return products;
    }
  }
}



  // print(PriceSort().sortProducts(products, true));

  // print(NameSort().sortProducts(products));
  // print(QuantitySort().sortProducts(products));

  // for (Product product in sortedProducts.sortByPrice(
  //   products,
  // )) {
  //   print(product);
  // }
// }
