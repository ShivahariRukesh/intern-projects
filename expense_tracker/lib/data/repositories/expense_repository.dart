import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/data/services/expense_service.dart';
import 'package:flutter/widgets.dart';

class ExpenseRepository {
  final ExpenseService _service;

  const ExpenseRepository(this._service);

  void createExpense(ExpenseModel expense) async {
    try {
      await _service.create(expense);
    } on Exception catch (excep) {
      debugPrint(
        'Error while creating an expense : $excep',
      );
      throw Exception(excep);
    }
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    try {
      final res = await _service.fetchAll();
      return res;
    } on Exception catch (excep) {
      debugPrint(
        'Error when fetching all expenses : $excep',
      );
      throw Exception(excep);
    }
  }

  void deleteExpense(String id) async {
    try {
      await _service.delete(id);
    } on Exception catch (excep) {
      debugPrint(
        'Errorr while deleting an expense : $excep',
      );
      throw Exception(excep);
    }
  }

  void updateExpense(ExpenseModel editedExpense) async {
    try {
      await _service.update(editedExpense);
    } on Exception catch (excep) {
      debugPrint(
        'Error while updating an expense : $excep',
      );
      throw Exception(excep);
    }
  }
}
