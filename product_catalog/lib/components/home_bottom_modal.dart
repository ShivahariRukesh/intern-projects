// import 'package:flutter/material.dart';
// import 'package:product_catalog/models/product_model.dart';

// class HomeBottomModal extends StatefulWidget {
//   List<Product> productResults;
//   String? sortDropDownValue;
//   bool isAscending;
//   HomeBottomModal({
//     super.key,
//     required this.productResults,
//     this.sortDropDownValue,
//     required this.isAscending,
//   });
//   @override
//   State<StatefulWidget> createState() => _HomeBottomModal();
// }

// class _HomeBottomModal extends State<HomeBottomModal> {
//   Set<String> selectedTypes = {};
//   double? minPrice;
//   double? maxPrice;

//   void _applyFiltersAndSort() {
//     List<Product> filtered = ProductFilter.filterProducts(
//       products,
//       selectedTypes: selectedTypes,
//       minPrice: minPrice,
//       maxPrice: maxPrice,
//     );

//     setState(() {
//       widget.productResults =
//           ProductResults.manipulateResult(
//             widget.sortDropDownValue!.toLowerCase(),
//             widget.isAscending,
//             filtered,
//           );
//     });
//   }

//   void _showFilterSheet(BuildContext context) {
//     Set<String> tempTypes = Set.from(selectedTypes);
//     double? tempMin = minPrice;
//     double? tempMax = maxPrice;

//     showModalBottomSheet(
//       context: context,
//       backgroundColor: const Color.fromARGB(
//         255,
//         174,
//         172,
//         160,
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(16),
//         ),
//       ),
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setSheetState) {
//             return Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Filter by Type",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   CheckboxListTile(
//                     title: Text("Instrument"),
//                     value: tempTypes.contains('Instrument'),
//                     onChanged: (val) => setSheetState(
//                       () => val!
//                           ? tempTypes.add('Instrument')
//                           : tempTypes.remove('Instrument'),
//                     ),
//                   ),
//                   CheckboxListTile(
//                     title: Text("Mobile"),
//                     value: tempTypes.contains('Mobile'),
//                     onChanged: (val) => setSheetState(
//                       () => val!
//                           ? tempTypes.add('Mobile')
//                           : tempTypes.remove('Mobile'),
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     "Filter by Price Range",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             labelText: "Min Price",
//                           ),
//                           keyboardType:
//                               TextInputType.number,
//                           onChanged: (val) => tempMin =
//                               double.tryParse(val),
//                         ),
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: TextField(
//                           decoration: InputDecoration(
//                             labelText: "Max Price",
//                           ),
//                           keyboardType:
//                               TextInputType.number,
//                           onChanged: (val) => tempMax =
//                               double.tryParse(val),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   Row(
//                     mainAxisAlignment:
//                         MainAxisAlignment.spaceBetween,
//                     children: [
//                       TextButton(
//                         child: Text("Clear Filters"),
//                         onPressed: () {
//                           setState(() {
//                             selectedTypes = {};
//                             minPrice = null;
//                             maxPrice = null;
//                           });
//                           _applyFiltersAndSort();
//                           Navigator.pop(context);
//                         },
//                       ),
//                       ElevatedButton(
//                         child: Text("Apply"),
//                         onPressed: () {
//                           setState(() {
//                             selectedTypes = tempTypes;
//                             minPrice = tempMin;
//                             maxPrice = tempMax;
//                           });
//                           _applyFiltersAndSort();
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }

//   void showModal() {
//     _showFilterSheet(context);
//   }

//   @override
//   Widget build(BuildContext build) {
//     // return (_showFilterSheet(context));
//     return Text("GG");
//   }
// }
