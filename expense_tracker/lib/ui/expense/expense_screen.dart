import 'package:expense_tracker/ui/expense/view_models/expense_view_model.dart';
import 'package:expense_tracker/ui/expense/widgets/expense_add_bottom_sheet_widget.dart';
import 'package:expense_tracker/ui/expense/widgets/expense_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() =>
      _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpenseViewModel>().loadExpenses();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        padding: const EdgeInsets.all(15),
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
