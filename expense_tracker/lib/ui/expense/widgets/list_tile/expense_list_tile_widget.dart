import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/ui/expense/widgets/list_tile/list_tile_end_widget.dart';
import 'package:expense_tracker/ui/expense/widgets/list_tile/list_tile_index_icon_widget.dart';
import 'package:flutter/material.dart';

/// It is the list tile widget to display individual expense details
class ExpenseListTileWidget extends StatelessWidget {
  /// [index] Position of an expense in the lists of expense
  final int index;

  /// [expenseDetail] Holds the data of a single expense.
  final ExpenseModel expenseDetail;

  /// [onDeleteExpense] Callback function triggered when deleting an expense.
  /// It provides the current [BuildContext] and index of the expense.
  final void Function(BuildContext, int) onDeleteExpense;

  /// [onEditExpense] Callback function triggered when editing an expense.
  /// It provides the current [BuildContext] and the selected [ExpenseModel].
  final void Function(BuildContext, ExpenseModel)
  onEditExpense;

  /// [onViewExpenseModal] Callback function triggered when viewing expense details.
  /// It provides the current [BuildContext] and the selected [ExpenseModel].
  final void Function(BuildContext, ExpenseModel)
  onViewExpenseModal;

  /// Parameters:
  /// There are 5 named parameters:
  /// - [key] : An optional parameter that identifies widget in the widget tree
  /// - [index] : A required parameter of type int.
  /// - [expenseDetail]: A required parameter of type ExpenseModel.
  /// - [onViewExpenseModal]: A required callback function.
  /// - [onDeleteExpense]: A required callback function.
  /// - [onEditExpense]: A required callback function.
  const ExpenseListTileWidget({
    super.key,
    required this.index,
    required this.expenseDetail,
    required this.onViewExpenseModal,
    required this.onDeleteExpense,
    required this.onEditExpense,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () =>
          onViewExpenseModal(context, expenseDetail),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF334155),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ListTileIndexIcon(listIndex: index),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                expenseDetail.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 10),
            ListTileEndWidget(
              expenseDetail: expenseDetail,
              onDeleteExpense: onDeleteExpense,
              onEditExpense: onEditExpense,
            ),
          ],
        ),
      ),
    );
  }
}
