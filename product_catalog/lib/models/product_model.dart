// import 'package:flutter/widgets.dart';

class Searchable {
  void search() {}
}

abstract class Sortable {
  List<Product> sortProducts(
    List<Product> products, [
    bool isAscending,
  ]);
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
    isAscending = false,
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
  final String name;
  final double price;
  final int quantity;

  Product({
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
    required super.name,
    required super.price,
    required super.quantity,
  });

  @override
  void displayProductType() {
    print("Mobile Accessories");
  }
}

// void main() {
List<Product> products = [
  Instrument(name: 'Guitar', price: 5000, quantity: 2),
  Instrument(name: 'Keyboard', price: 9000, quantity: 5),
  Instrument(name: 'Violin', price: 3000, quantity: 2),

  Mobile(name: 'Iphone 15', price: 45000, quantity: 3),
  Mobile(name: 'Iphone 17', price: 65000, quantity: 4),
  Mobile(name: 'Samsung', price: 30000, quantity: 8),
];

  // print(PriceSort().sortProducts(products, true));

  // print(NameSort().sortProducts(products));
  // print(QuantitySort().sortProducts(products));

  // for (Product product in sortedProducts.sortByPrice(
  //   products,
  // )) {
  //   print(product);
  // }
// }
