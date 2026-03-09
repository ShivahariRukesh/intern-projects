import 'package:flutter/widgets.dart';

//Searchable Interface
abstract class Searchable {
  List<Product> searchProducts(String name);
}

//Sortable Interface
abstract class Sortable {
  List<Product> sortProducts(
    List<Product> products, [
    bool isAscending,
  ]);
}

//NameSearch Class Implementing Searchable Interface
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

//PriceSort Class Implementing Sortable Interface
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

//QuantitySort Class Implementing Sortable Interface
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

//NameSort Class Implementing Sortable Interface
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

//Product Class
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
    debugPrint("$name : $price");
  }

  void displayProductType();
}

//Instrument Class Extending Product
class Instrument extends Product {
  Instrument({
    super.imageUrl,
    required super.name,
    required super.price,
    required super.quantity,
  });

  @override
  void displayProductType() {
    debugPrint("Soulful Instrument");
  }
}

//Mobile Class Extending Product
class Mobile extends Product {
  Mobile({
    super.imageUrl,
    required super.name,
    required super.price,
    required super.quantity,
  });

  @override
  void displayProductType() {
    debugPrint("Mobile Accessories");
  }
}

//ProductResults class to manipulate the product into the filtered or sorted product results
class ProductResults {
  // static List<Product> manipulateResult(
  //   String type, [
  //   bool isAscending = true,
  // ]) {
  //   switch (type) {
  //     case "name":
  //       return NameSort().sortProducts(
  //         products,
  //         isAscending,
  //       );
  //     case "price":
  //       return PriceSort().sortProducts(
  //         products,
  //         isAscending,
  //       );
  //     case "quantity":
  //       return QuantitySort().sortProducts(
  //         products,
  //         isAscending,
  //       );
  //     default:
  //       return products;
  //   }
  // }

  static List<Product> filterProducts(
    List<Product> productList, {
    Set<String> selectedTypes = const {},
    double? minPrice,
    double? maxPrice,
  }) {
    var gg = productList.where((product) {
      // Type filter
      final typeMatch =
          selectedTypes.isEmpty ||
          (selectedTypes.contains('Instrument') &&
              product is Instrument) ||
          (selectedTypes.contains('Mobile') &&
              product is Mobile);

      // Price filter
      final priceMatch =
          (minPrice == null || product.price >= minPrice) &&
          (maxPrice == null || product.price <= maxPrice);

      return typeMatch && priceMatch;
    }).toList();
    return gg;
  }

  static List<Product> sortProducts(
    String sortLabel, [
    bool isAscending = true,
    List<Product>? productList,
  ]) {
    final list = productList ?? products;
    switch (sortLabel) {
      case "name":
        return NameSort().sortProducts(list, isAscending);
      case "price":
        return PriceSort().sortProducts(list, isAscending);
      case "quantity":
        return QuantitySort().sortProducts(
          list,
          isAscending,
        );
      default:
        return list;
    }
  }
}

//Manual entry of products list
List<Product> products = [
  Instrument(
    imageUrl: 'assets/images/guitar.jpg',
    name: 'Guitar',
    price: 5000,
    quantity: 2,
  ),
  Instrument(
    imageUrl: 'assets/images/keyboard.jpeg',
    name: 'Keyboard',
    price: 9000,
    quantity: 5,
  ),
  Instrument(
    imageUrl: 'assets/images/violin.webp',
    name: 'Violin',
    price: 3000,
    quantity: 2,
  ),

  Mobile(
    imageUrl: 'assets/images/iphone15.jpg',
    name: 'Iphone 15',
    price: 100000,
    quantity: 3,
  ),
  Mobile(
    imageUrl: 'assets/images/iphone17pro.jpg',
    name: 'Iphone 17 Pro',
    price: 200000,
    quantity: 4,
  ),
  Mobile(
    imageUrl: 'assets/images/samsungs25ultra.jpg',
    name: 'Samsung S25 Ultra',
    price: 180000,
    quantity: 8,
  ),
];
