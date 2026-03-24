import 'package:expense_tracker/ui/expense/widgets/expense_form_widget.dart';
import 'package:flutter/material.dart';

class ExpenseAddBottomSheetWidget extends StatelessWidget {
  const ExpenseAddBottomSheetWidget({super.key});

  void onCreateExpenseBottomModalSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ExpenseFormWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Back to the screen");
    return OutlinedButton(
      onPressed: () =>
          onCreateExpenseBottomModalSheet(context),
      child: const Icon(Icons.plus_one, size: 20),
    );
  }
}
