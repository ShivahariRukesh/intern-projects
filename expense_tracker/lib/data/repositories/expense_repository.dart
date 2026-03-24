import 'dart:collection';

import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:flutter/widgets.dart';

class ExpenseRepository {
  List<ExpenseModel> _expenseList = [];

  void createExpense(ExpenseModel expense) {
    try {
      _expenseList.add(expense);
    } on Exception catch (excep) {
      debugPrint(
        'Error while creating an expense : $excep',
      );
    }
  }

  UnmodifiableListView<ExpenseModel>? getAllExpenses() {
    try {
      UnmodifiableListView<ExpenseModel>
      unmodifiedExpenseList = UnmodifiableListView(
        _expenseList,
      );
      return unmodifiedExpenseList;
    } on Exception catch (excep) {
      debugPrint(
        'Error when fetching all expenses : $excep',
      );
      return null;
    }
  }

  void deleteExpense(int id) {
    try {
      _expenseList.removeWhere(
        (expense) => expense.expenseId == id,
      );
    } on Exception catch (excep) {
      debugPrint(
        "Errorr while deleting an expense : $excep",
      );
    }
  }

  void updateExpense(ExpenseModel editedExpense) {
    try {
      _expenseList.firstWhere(
        (expense) =>
            expense.expenseId == editedExpense.expenseId,
      );
    } on Exception catch (excep) {
      debugPrint(
        "Error while updating an expense : $excep",
      );
    }
  }
}
