import 'package:flutter/material.dart';

class ExpenseShowModalWidget extends StatelessWidget {
  final Map<String, String?> _currentExpenseDetail;
  ExpenseShowModalWidget(currentExpenseDetail, {super.key})
    : _currentExpenseDetail = currentExpenseDetail;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.amber,
        ),

        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
              ),
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_currentExpenseDetail["id"]!),
                Text(_currentExpenseDetail["title"]!),

                Expanded(
                  child: Text(
                    _currentExpenseDetail["description"] ??
                        "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Text(_currentExpenseDetail["amount"]!),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
