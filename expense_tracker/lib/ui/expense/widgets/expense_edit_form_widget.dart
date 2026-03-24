import 'package:expense_tracker/ui/expense/view_models/expense_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseEditFormWidget extends StatelessWidget {
  final Map<String, Object?> _currentExpenseDetail;
  ExpenseEditFormWidget(currentExpenseDetail, {super.key})
    : _currentExpenseDetail = currentExpenseDetail;

  final TextEditingController _expenseTitleController =
      TextEditingController();
  final TextEditingController
  _expenseDescriptionController = TextEditingController();
  final TextEditingController _expenseAmountController =
      TextEditingController();

  void onFormSubmit(BuildContext context) {
    Provider.of<ExpenseViewModel>(
      context,
      listen: false,
    ).updateExpense(
      _currentExpenseDetail["id"] as int,
      title: _expenseTitleController.text,
      description: _expenseDescriptionController.text,
      amount:
          double.tryParse(_expenseAmountController.text) ??
          0,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    _expenseTitleController.text =
        _currentExpenseDetail["title"] as String;

    _expenseDescriptionController.text =
        _currentExpenseDetail["description"] as String? ??
        "";

    _expenseAmountController.text =
        _currentExpenseDetail["amount"] as String;

    print('Edit form build');
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Center(child: Text('Edit Your Expense')),
          TextField(
            controller: _expenseTitleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              hintText: 'Write title for your expense',
            ),
          ),

          TextField(
            controller: _expenseDescriptionController,
            decoration: const InputDecoration(
              labelText: 'Description',
              hintText:
                  'Write description for your expense',
            ),
          ),

          TextField(
            controller: _expenseAmountController,
            decoration: const InputDecoration(
              labelText: 'Amount',
              hintText: 'Write the amount you have spent',
            ),
          ),

          ElevatedButton(
            onPressed: () => onFormSubmit(context),
            child: const Text('Edit'),
          ),
        ],
      ),
    );
  }
}
