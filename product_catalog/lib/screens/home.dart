import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_catalog/components/product_drawer.dart';
import 'package:product_catalog/components/products_grid_view.dart';
import 'package:product_catalog/models/product_model.dart';
import 'package:product_catalog/screens/product_search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String sortDropDownValue = 'Price';
  List<Product> productResults = products;
  bool isAscending = true;

  Set<String> selectedTypes = {};
  double? minPrice;
  double? maxPrice;

  void _applyFiltersAndSort() {
    List<Product> filteredProductResults =
        ProductResults.filterProducts(
          products,
          selectedTypes: selectedTypes,
          minPrice: minPrice,
          maxPrice: maxPrice,
        );
    // setState(() {
    //   productResults = filteredProductResults;
    // });

    setState(() {
      productResults = ProductResults.sortProducts(
        sortDropDownValue!.toLowerCase(),
        isAscending,
        filteredProductResults,
      );
    });
  }

  void _showFilterSheet(BuildContext context) {
    Set<String> tempTypes = Set.from(selectedTypes);
    double? tempMin = minPrice;
    double? tempMax = maxPrice;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color.fromARGB(
        255,
        174,
        172,
        160,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filter by Type",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  CheckboxListTile(
                    title: Text("Instrument"),
                    value: tempTypes.contains('Instrument'),
                    onChanged: (val) => setSheetState(
                      () => val!
                          ? tempTypes.add('Instrument')
                          : tempTypes.remove('Instrument'),
                    ),
                  ),
                  CheckboxListTile(
                    title: Text("Mobile"),
                    value: tempTypes.contains('Mobile'),
                    onChanged: (val) => setSheetState(
                      () => val!
                          ? tempTypes.add('Mobile')
                          : tempTypes.remove('Mobile'),
                    ),
                  ),
                  SizedBox(height: 8),

                  //Price range filter
                  Text(
                    "Filter by Price Range",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      //Minimum Price Input
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Min Price",
                          ),

                          keyboardType:
                              TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                          onChanged: (val) => tempMin =
                              double.tryParse(val),
                        ),
                      ),
                      SizedBox(width: 16),

                      //Maximum Price Input
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Max Price",
                          ),
                          keyboardType:
                              TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                          onChanged: (val) => tempMax =
                              double.tryParse(val),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        child: Text("Clear Filters"),
                        onPressed: () {
                          setState(() {
                            selectedTypes = {};
                            minPrice = null;
                            maxPrice = null;
                          });
                          _applyFiltersAndSort();
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton(
                        child: Text("Apply"),
                        onPressed: () {
                          setState(() {
                            selectedTypes = tempTypes;
                            minPrice = tempMin;
                            maxPrice = tempMax;
                          });
                          _applyFiltersAndSort();
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Products"),
            SizedBox(width: 20),

            //Sorting Dropdown
            DropdownButton<String>(
              icon: const Icon(
                Icons.swap_vert,
                color: Colors.black,
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
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
                  if (value == sortDropDownValue) {
                    isAscending = !isAscending;
                  } else {
                    isAscending = true;
                  }
                  sortDropDownValue = value!;
                  productResults =
                      ProductResults.sortProducts(
                        value!.toLowerCase(),
                        isAscending,
                        productResults,
                      );
                });
              },
            ),

            // Filter Icon
            IconButton(
              icon: Icon(
                Icons.filter_list,
                color:
                    selectedTypes.isNotEmpty ||
                        minPrice != null ||
                        maxPrice != null
                    ? Colors.yellow
                    : Colors.black,
              ),
              onPressed: () => _showFilterSheet(context),
              // onPressed: () => HomeBottomModal(
              //   productResults: productResults,
              //   sortDropDownValue: sortDropDownValue,
              //   isAscending: isAscending,
              // ),
            ),

            //Show All Products
            IconButton(
              icon: Icon(Icons.all_inbox),
              onPressed: () => setState(() {
                productResults = products;
              }),
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

      drawer: ProductDrawer(),
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
