import 'dart:collection';
import 'dart:math';

import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/ui/expense/view_models/expense_view_model.dart';
import 'package:expense_tracker/ui/expense/widgets/expense_edit_form_widget.dart';
import 'package:expense_tracker/ui/expense/widgets/expense_list_tile_widget.dart';
import 'package:expense_tracker/ui/expense/widgets/expense_show_modal_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseListWidget extends StatelessWidget {
  ExpenseListWidget({super.key});

  void onDeleteExpense(BuildContext context, int id) {
    Provider.of<ExpenseViewModel>(
      context,
      listen: false,
    ).deleteExpense(id);
  }

  void onEditExpense(
    BuildContext context,
    Map<String, Object?> currentExpenseDetail,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
          ExpenseEditFormWidget(currentExpenseDetail),
    );
  }

  void onViewExpenseModal(
    BuildContext context,
    Map<String, String?> currentExpenseDetail,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          ExpenseShowModalWidget(currentExpenseDetail),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UnmodifiableListView<ExpenseModel>? expenseList =
        context.watch<ExpenseViewModel>().getAllExpenses();

    return Expanded(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 137, 43, 43),
        ),
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            context
                .read<ExpenseViewModel>()
                .reorderExpenses(oldIndex, newIndex);
          },
          padding: const EdgeInsets.all(5),
          children: expenseList!
              .map(
                (expense) => ExpenseListTileWidget(
                  key: Key('${expense.expenseId}'),
                  id: expense.expenseId,
                  title: expense.title,
                  description: expense.description,
                  amount: expense.expenseAmount,
                  onDeleteExpense: onDeleteExpense,
                  onEditExpense: onEditExpense,
                  onViewExpenseModal: onViewExpenseModal,
                ),
              )
              .toList(),
        ),

        // child: ListView(
        //   padding: const EdgeInsets.all(5),
        //   children: context
        //       .watch<ExpenseViewModel>()
        //       .getAllExpenses()!
        //       .map(
        //         (expense) => GestureDetector(
        //           child: ExpenseListTileWidget(
        //             id: expense.expenseId,
        //             title: expense.title,
        //             description: expense.description,
        //             amount: expense.expenseAmount,
        //             onDeleteExpense: onDeleteExpense,
        //             onEditExpense: onEditExpense,
        //             onViewExpenseModal: onViewExpenseModal,
        //           ),
        //         ),
        //       )
        //       .toList(),
        // ),
      ),
    );
  }
}
