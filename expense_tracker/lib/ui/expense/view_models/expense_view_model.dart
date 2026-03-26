import 'dart:collection';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/data/repositories/expense_repository.dart';
import 'package:flutter/material.dart';

/// A ViewModel that manages expense state and business logic.
///
/// Acts as a bridge between the UI and [ExpenseRepository].
class ExpenseViewModel extends ChangeNotifier {
  final ExpenseRepository _repository;

  /// Creates an [ExpenseViewModel] with the given [ExpenseRepository].
  ExpenseViewModel({required repository})
    : _repository = repository;

  List<ExpenseModel> _expenseList = [];

  /// An unmodifiable view of the current list of expenses.
  ///
  /// Prevents external modification while allowing read access.
  UnmodifiableListView<ExpenseModel> get expenseList =>
      UnmodifiableListView(_expenseList);

  int? _randomNumberSeed;

  /// Creates a new expense and updates the local state.
  ///
  /// Generates a simple incremental ID, persists the expense via
  /// the repository, and notifies listeners.
  void createExpense({
    required String title,
    String? description,
    required double amount,
  }) {
    try {
      int id = _randomNumberSeed ?? 1;

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
    } on Exception catch (e) {
      debugPrint('Error while creating an expense : $e');
    }
  }

  /// Loads all expenses from the repository.
  ///
  /// Updates the internal list and notifies listeners
  /// to refresh the UI.
  Future<void> loadExpenses() async {
    try {
      final result = await _repository.getAllExpenses();
      _expenseList = result;
      _randomNumberSeed = _expenseList.length + 1;
      notifyListeners();
    } on Exception catch (e) {
      debugPrint('Error when fetching all expenses : $e');
    }
  }

  /// Deletes an expense by its [id].
  ///
  /// Removes the expense from both the repository and local state,
  /// then notifies listeners.
  void deleteExpense(String id) {
    try {
      _repository.deleteExpense(id);

      _expenseList.removeWhere(
        (expense) => expense.expenseId == int.parse(id),
      );

      notifyListeners();
    } on Exception catch (e) {
      debugPrint('Error while deleting an expense : $e');
    }
  }

  /// Updates an existing expense.
  ///
  /// Finds the expense by [id], replaces it with updated data,
  /// persists the change, and notifies listeners.
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
    } on Exception catch (e) {
      debugPrint('Error while updating an expense : $e');
    }
  }

  /// Reorders the expense list.
  ///
  /// Moves an item from [oldIndex] to [newIndex] and notifies listeners.
  /// Useful for drag-and-drop UI interactions.
  void reorderExpenses(int oldIndex, int newIndex) {
    final list = _expenseList;

    final item = list.removeAt(oldIndex);
    list.insert(newIndex, item);

    notifyListeners();
  }
}
