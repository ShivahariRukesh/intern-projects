import 'package:flutter/material.dart';

class ExpenseShowModalWidget extends StatelessWidget {
  final Map<String, Object?> _currentExpenseDetail;
  const ExpenseShowModalWidget(
    this._currentExpenseDetail, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor:
          Colors.transparent, // remove default dialog bg
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(
            0xFF0F172A,
          ), // dark modal background
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// CLOSE BUTTON
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(
                  Icons.close_rounded,
                  color: Colors.white70,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(height: 8),

            /// ID + TITLE
            Row(
              children: [
                Text(
                  "#${_currentExpenseDetail["id"]}",
                  style: const TextStyle(
                    color: Colors.white38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _currentExpenseDetail['title']
                        as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// DESCRIPTION
            if (_currentExpenseDetail['description'] !=
                    null &&
                (_currentExpenseDetail['description']
                        as String)
                    .isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _currentExpenseDetail['description']
                      as String,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ),

            const SizedBox(height: 16),

            /// AMOUNT
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Amount',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 14,
                  ),
                ),
                Text(
                  "Rs. ${_currentExpenseDetail["amount"] ?? "0"}",
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
