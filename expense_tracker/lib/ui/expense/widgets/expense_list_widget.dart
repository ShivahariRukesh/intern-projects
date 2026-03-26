import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/ui/core/shared/base_form_widget.dart';
import 'package:expense_tracker/ui/expense/view_models/expense_view_model.dart';
import 'package:expense_tracker/ui/expense/widgets/list_tile/expense_list_tile_widget.dart';
import 'package:expense_tracker/ui/expense/widgets/expense_show_modal_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// It displays all the available expenses
class ExpenseListWidget extends StatelessWidget {
  const ExpenseListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ExpenseViewModel vm = context
        .watch<ExpenseViewModel>();
    final double width = MediaQuery.of(context).size.width;

    if (vm.expenseList.isEmpty) {
      return _emptyExpenseListWidget();
    }

    if (width > 600) {
      return _tabletScreenSizeResponsiveWidget(vm);
    }

    return _defaultScreenSizeResponsiveWidget(vm, context);
  }

  Center _emptyExpenseListWidget() {
    return const Center(
      child: Text(
        'No expenses yet',
        style: TextStyle(color: Colors.white, fontSize: 34),
      ),
    );
  }

  ReorderableListView _defaultScreenSizeResponsiveWidget(
    ExpenseViewModel vm,
    BuildContext context,
  ) {
    return ReorderableListView.builder(
      itemCount: vm.expenseList.length,
      proxyDecorator: (child, index, animation) {
        return Material(
          color: Colors.transparent,
          child: child,
        );
      },
      onReorder: (oldIndex, newIndex) {
        if (newIndex > oldIndex) newIndex -= 1;
        context.read<ExpenseViewModel>().reorderExpenses(
          oldIndex,
          newIndex,
        );
      },
      itemBuilder: (context, index) {
        final expense = vm.expenseList[index];
        return Padding(
          key: ValueKey(expense.expenseId),
          padding: const EdgeInsets.only(bottom: 10),
          child: ExpenseListTileWidget(
            index: index,
            expenseDetail: expense,
            onDeleteExpense: onDeleteExpense,
            onEditExpense: onEditExpense,
            onViewExpenseModal: onViewExpenseModal,
          ),
        );
      },
    );
  }

  Widget _tabletScreenSizeResponsiveWidget(
    ExpenseViewModel vm,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
      itemCount: vm.expenseList.length,
      itemBuilder: (context, index) {
        final expense = vm.expenseList[index];

        return ExpenseListTileWidget(
          index: index,
          expenseDetail: expense,
          onDeleteExpense: onDeleteExpense,
          onEditExpense: onEditExpense,
          onViewExpenseModal: onViewExpenseModal,
        );
      },
    );
  }

  void onDeleteExpense(BuildContext context, int id) {
    Provider.of<ExpenseViewModel>(
      context,
      listen: false,
    ).deleteExpense(id.toString());
  }

  void onEditExpense(
    BuildContext context,
    ExpenseModel currentExpenseDetail,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E293B),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (_) => BaseFormWidget(
        titleText: 'Edit Expense',
        buttonText: 'Update Expense',
        initialData: currentExpenseDetail,
        onSubmit: (ctx, title, desc, amount) {
          ctx.read<ExpenseViewModel>().updateExpense(
            currentExpenseDetail.expenseId,
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
    ExpenseModel currentExpenseDetail,
  ) {
    showDialog(
      context: context,
      builder: (context) => ExpenseShowModalWidget(
        currentExpenseDetail: currentExpenseDetail,
      ),
    );
  }
}
