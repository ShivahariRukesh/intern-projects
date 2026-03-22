import 'package:expense_tracker/ui/expense/widgets/expense_add_bottom_sheet_widget.dart';
import 'package:expense_tracker/ui/expense/widgets/expense_list_widget.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          spacing: 100,
          children: [
            ExpenseListWidget(),
            const ExpenseAddBottomSheetWidget(),
          ],
        ),
      ),
    );
  }
}
