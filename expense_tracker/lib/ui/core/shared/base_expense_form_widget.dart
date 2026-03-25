import 'package:flutter/material.dart';

class BaseExpenseFormWidget extends StatelessWidget {
  final String titleText; // "Add Expense" / "Edit Expense"
  final String
  buttonText; // "Save Expense" / "Update Expense"
  final void Function(BuildContext, String, String, double)
  onSubmit;
  final Map<String, Object?>? initialData;

  BaseExpenseFormWidget({
    super.key,
    required this.titleText,
    required this.buttonText,
    required this.onSubmit,
    this.initialData,
  });

  final TextEditingController _expenseTitleController =
      TextEditingController();
  final TextEditingController
  _expenseDescriptionController = TextEditingController();
  final TextEditingController _expenseAmountController =
      TextEditingController();

  InputDecoration _inputDecoration(
    String label,
    String hint,
  ) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFF1E293B),
      labelStyle: const TextStyle(color: Colors.white70),
      hintStyle: const TextStyle(color: Colors.white38),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Prefill if edit
    if (initialData != null) {
      _expenseTitleController.text =
          initialData!['title'] as String? ?? '';
      _expenseDescriptionController.text =
          initialData!['description'] as String? ?? '';
      _expenseAmountController.text =
          initialData!['amount']?.toString() ?? '';
    }

    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom:
            MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Drag handle
            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            Text(
              titleText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// Title
            TextField(
              controller: _expenseTitleController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration(
                'Title',
                'e.g. Lunch, Taxi, Groceries',
              ),
            ),

            const SizedBox(height: 16),

            /// Description
            TextField(
              controller: _expenseDescriptionController,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration(
                'Description',
                'Optional note...',
              ),
            ),

            const SizedBox(height: 16),

            /// Amount
            TextField(
              controller: _expenseAmountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: _inputDecoration(
                'Amount',
                'Enter amount',
              ).copyWith(prefixText: 'Rs. '),
            ),

            const SizedBox(height: 24),

            /// Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final title =
                      _expenseTitleController.text;
                  final desc =
                      _expenseDescriptionController.text;
                  final amt =
                      double.tryParse(
                        _expenseAmountController.text,
                      ) ??
                      0;
                  onSubmit(context, title, desc, amt);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
