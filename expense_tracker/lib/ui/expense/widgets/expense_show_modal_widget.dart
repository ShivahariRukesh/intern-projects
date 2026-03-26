import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/ui/expense/widgets/scroll_view_expense_widget.dart';
import 'package:flutter/material.dart';

/// Shows the selected expense
///
/// It displays an expense that was selected from the lists in a modal widget.
class ExpenseShowModalWidget extends StatelessWidget {
  /// [currentExpenseDetail] retains the information about selected expense from the lists
  final ExpenseModel currentExpenseDetail;

  /// [currentExpenseDetail] is of[ExpenseModel] data type
  ExpenseShowModalWidget({
    required this.currentExpenseDetail,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmall = size.width < 400;
    final String title = currentExpenseDetail.title;
    final String? description =
        currentExpenseDetail.description;
    final double amount =
        currentExpenseDetail.expenseAmount;

    return Dialog(
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ScrollViewExpenseWidget(
            isSmall: isSmall,
            title: title,
            description: description,
            amount: amount,
          ),
        ),
      ),
    );
  }
}
