import 'package:flutter/widgets.dart';

abstract class Product {
  final String name;
  final double price;
  final int quantity;

  Product({
    required this.name,
    required this.price,
    required this.quantity,
  });

  void display() {
    debugPrint("$name : $price");
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
    debugPrint("Soulful Instrument");
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
    debugPrint("Mobile Accessories");
  }
}

List<Product> products = [
  Instrument(name: 'Guitar', price: 5000, quantity: 2),
  Instrument(name: 'Keyboard', price: 9000, quantity: 5),
  Instrument(name: 'Violin', price: 3000, quantity: 2),

  Mobile(name: 'Iphone 15', price: 45000, quantity: 3),
  Mobile(name: 'Iphone 17', price: 65000, quantity: 4),
  Mobile(name: 'Samsung', price: 30000, quantity: 8),
];
