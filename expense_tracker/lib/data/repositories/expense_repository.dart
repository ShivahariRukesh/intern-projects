import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/data/services/expense_service.dart';
import 'package:flutter/widgets.dart';

/// A repository that provides an abstraction layer over [ExpenseService].
///
/// Handles data operations for expenses and centralizes error handling.
class ExpenseRepository {
  final ExpenseService _service;

  /// Creates an [ExpenseRepository] with the given [ExpenseService].
  const ExpenseRepository(this._service);

  /// Creates a new expense.
  ///
  /// Delegates the operation to [ExpenseService.create].
  /// Logs and rethrows any exceptions encountered.
  void createExpense(ExpenseModel expense) async {
    try {
      await _service.create(expense);
    } on Exception catch (ex) {
      debugPrint('Error while creating an expense : $ex');
      throw Exception(ex);
    }
  }

  /// Retrieves all stored expenses.
  ///
  /// Returns a list of [ExpenseModel]. Logs and rethrows
  /// any exceptions encountered during fetching.
  Future<List<ExpenseModel>> getAllExpenses() async {
    try {
      final res = await _service.fetchAll();
      return res;
    } on Exception catch (ex) {
      debugPrint('Error when fetching all expenses : $ex');
      throw Exception(ex);
    }
  }

  /// Deletes an expense by its [id].
  ///
  /// Delegates the operation to [ExpenseService.delete].
  /// Logs and rethrows any exceptions encountered.
  void deleteExpense(String id) async {
    try {
      await _service.delete(id);
    } on Exception catch (ex) {
      debugPrint('Error while deleting an expense : $ex');
      throw Exception(ex);
    }
  }

  /// Updates an existing expense.
  ///
  /// Matches the expense by its ID and replaces it with the updated value.
  /// Logs and rethrows any exceptions encountered.
  void updateExpense(ExpenseModel editedExpense) async {
    try {
      await _service.update(editedExpense);
    } on Exception catch (ex) {
      debugPrint('Error while updating an expense : $ex');
      throw Exception(ex);
    }
  }
}
