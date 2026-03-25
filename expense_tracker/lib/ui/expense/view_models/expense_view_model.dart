import 'dart:collection';

import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:flutter/material.dart';

class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository _repository;

  ExpenseViewModel({required repository})
    : _repository = repository;

  List<ExpenseModel> _expenseList = [];

  UnmodifiableListView<ExpenseModel> get expenseList =>
      UnmodifiableListView(_expenseList);
  int _randomNumberSeed = 1;

  void createExpense({
    required String title,
    String? description,
    required double amount,
  }) {
    try {
      int id = _randomNumberSeed;

      final expense = ExpenseModel(
        expenseId: id,
        description: description,
        title: title,
        expenseAmount: amount,
      );

      _repository.createExpense(expense);
      _expenseList.add(expense);
      _randomNumberSeed = id + 1;
      notifyListeners();
    } on Exception catch (excep) {
      debugPrint(
        'Error while creating an expense : $excep',
      );
    }
  }

  Future<void> loadExpenses() async {
    try {
      final result = await _repository.getAllExpenses();
      _expenseList = result;
      notifyListeners();
    } on Exception catch (excep) {
      debugPrint(
        'Error when fetching all expenses : $excep',
      );
    }
  }

  void deleteExpense(String id) {
    try {
      _repository.deleteExpense(id);
      _expenseList.removeWhere(
        (expense) => expense.expenseId == int.parse(id),
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
      final expense = ExpenseModel(
        expenseId: id,
        title: title,
        expenseAmount: amount,
        description: description,
      );

      _repository.updateExpense(expense);
      _expenseList[expenseIndex] = expense;
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
