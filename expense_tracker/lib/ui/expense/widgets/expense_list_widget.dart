import 'package:expense_tracker/ui/core/shared/base_expense_form_widget.dart';
import 'package:expense_tracker/ui/expense/view_models/expense_view_model.dart';
import 'package:expense_tracker/ui/expense/widgets/expense_list_tile_widget.dart';
import 'package:expense_tracker/ui/expense/widgets/expense_show_modal_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({super.key});

  void onDeleteExpense(BuildContext context, int id) {
    Provider.of<ExpenseViewModel>(
      context,
      listen: false,
    ).deleteExpense(id.toString());
  }

  void onEditExpense(
    BuildContext context,
    Map<String, Object?> currentExpenseDetail,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => BaseExpenseFormWidget(
        titleText: 'Edit Expense',
        buttonText: 'Update Expense',
        initialData: {
          'id': currentExpenseDetail['id'],
          'title': currentExpenseDetail['title'],
          'description':
              currentExpenseDetail['description'] ?? '',
          'amount': currentExpenseDetail['amount']
              .toString(),
        },
        onSubmit: (ctx, title, desc, amount) {
          ctx.read<ExpenseViewModel>().updateExpense(
            currentExpenseDetail['id'] as int,
            title: title,
            description: desc,
            amount: amount,
          );
        },
      ),
    );
  }

  void onViewExpenseModal(
    BuildContext context,
    Map<String, Object?> currentExpenseDetail,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          ExpenseShowModalWidget(currentExpenseDetail),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ExpenseViewModel>();

    if (vm.expenseList.isEmpty) {
      return const Center(
        child: Text(
          'No expenses yet',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 16,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ReorderableListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: vm.expenseList.length,

        proxyDecorator: (child, index, animation) {
          return Material(
            color: Colors
                .transparent, // 🚨 removes white flicker
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                final elevation = 6.0 * animation.value;
                return Transform.scale(
                  scale: 1.02,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                            0.4,
                          ),
                          blurRadius: elevation,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: child,
                  ),
                );
              },
              child: child,
            ),
          );
        },

        onReorder: (oldIndex, newIndex) {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          context.read<ExpenseViewModel>().reorderExpenses(
            oldIndex,
            newIndex,
          );
        },

        itemBuilder: (context, index) {
          final expense = vm.expenseList[index];

          return Padding(
            key: Key('${expense.expenseId}'),
            padding: const EdgeInsets.only(bottom: 10),
            child: ExpenseListTileWidget(
              id: expense.expenseId,
              title: expense.title,
              description: expense.description,
              amount: expense.expenseAmount,
              onDeleteExpense: onDeleteExpense,
              onEditExpense: onEditExpense,
              onViewExpenseModal: onViewExpenseModal,
            ),
          );
        },
      ),
    );
  }
}
