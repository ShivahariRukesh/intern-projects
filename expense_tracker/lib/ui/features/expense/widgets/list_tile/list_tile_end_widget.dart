import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:flutter/material.dart';

/// It is the end section widget for a list tile to manage an individual expense
class ListTileEndWidget extends StatelessWidget {
  /// [expenseDetail] Holds the data of a single expense.
  final ExpenseModel expenseDetail;

  /// [onDeleteExpense] Callback function triggered when deleting an expense.
  /// It provides the current [BuildContext] and index of the expense.
  final void Function(BuildContext, int) onDeleteExpense;

  /// [onEditExpense] Callback function triggered when editing an expense.
  /// It provides the current [BuildContext] and the selected [ExpenseModel].
  final void Function(BuildContext, ExpenseModel)
  onEditExpense;

  /// Parameters:
  /// There are 4 named parameters:
  /// - [key] : An optional parameter that identifies widget in the widget tree.
  /// - [expenseDetail]: A required parameter of type ExpenseModel.
  /// - [onDeleteExpense]: A required callback function.
  /// - [onEditExpense]: A required callback function.
  const ListTileEndWidget({
    super.key,
    required this.expenseDetail,
    required this.onDeleteExpense,
    required this.onEditExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rs. ${expenseDetail.expenseAmount.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () =>
                  onEditExpense(context, expenseDetail),
              child: const Icon(
                Icons.edit,
                size: 18,
                color: Colors.white70,
              ),
            ),
            const SizedBox(width: 10),
            GestureDetector(
              onTap: () => onDeleteExpense(
                context,
                expenseDetail.expenseId,
              ),
              child: const Icon(
                Icons.delete,
                size: 18,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
