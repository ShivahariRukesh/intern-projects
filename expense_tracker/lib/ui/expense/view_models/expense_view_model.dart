import 'dart:collection';
import 'dart:math';

import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseViewModel extends ChangeNotifier {
  final List<ExpenseModel> _expenseList = [
    ExpenseModel(
      expenseId: 2,
      title: "title",
      description: "description",
      expenseAmount: 2222,
    ),
  ];
  int _randomNumberSeed = 1;
  void createExpense({
    required String title,
    String? description,
    required double amount,
  }) {
    try {
      int id =
          Random().nextInt(_randomNumberSeed) +
          _randomNumberSeed +
          10;
      _expenseList.add(
        ExpenseModel(
          expenseId: id,
          description: description,
          title: title,
          expenseAmount: amount,
        ),
      );
      _randomNumberSeed = id + 1;
      notifyListeners();
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
      notifyListeners();
    } on Exception catch (excep) {
      debugPrint(
        'Errorr while deleting an expense : $excep',
      );
    }
  }

  void updateExpense(
    int id, {
    required String title,
    String? description,
    required double amount,
  }) {
    try {
      final expenseIndex = _expenseList.indexWhere(
        (expense) => expense.expenseId == id,
      );
      _expenseList[expenseIndex] = ExpenseModel(
        expenseId: id,
        title: title,
        expenseAmount: amount,
        description: description,
      );
      notifyListeners();
    } on Exception catch (excep) {
      debugPrint(
        'Error while updating an expense : $excep',
      );
    }
  }

  void reorderExpenses(int oldIndex, int newIndex) {
    final list = _expenseList;

    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);

    notifyListeners();
  }
}
