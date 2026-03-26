import 'package:expense_tracker/ui/core/shared/base_expense_form_widget.dart';
import 'package:expense_tracker/ui/expense/view_models/expense_view_model.dart';
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

  void _openAddExpense() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      // isScrollControlled: true,
      context: context,
      builder: (_) => BaseExpenseFormWidget(
        titleText: 'Add Expense',
        buttonText: 'Save Expense',
        onSubmit: (ctx, title, desc, amount) {
          ctx.read<ExpenseViewModel>().createExpense(
            title: title,
            description: desc,
            amount: amount,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF0F172A,
      ), // modern dark blue
      appBar: AppBar(
        title: const Text(
          'Expenses Tracker',
          style: TextStyle(color: Colors.blueAccent),
        ),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpense,
        backgroundColor: const Color(0xFF6366F1),
        child: const Icon(Icons.add),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(height: 10),
            Expanded(child: ExpenseListWidget()),
          ],
        ),
      ),
    );
  }
}
