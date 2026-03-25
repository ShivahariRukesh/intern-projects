import 'dart:convert';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  static const _storageKey = 'expense';

  final SharedPreferences _prefs;
  ExpenseService(this._prefs);

  Future<List<ExpenseModel>> fetchAll() async {
    final raw = _prefs.getString(_storageKey);
    if (raw == null) return [];
    final List<dynamic> decoded =
        jsonDecode(raw) as List<dynamic>;
    return decoded
        .map(
          (e) => ExpenseModel.fromJson(
            e as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  // Future<ExpenseModel> create(ExpenseModel expense) async {
  //   final expenses = await fetchAll();
  //   expenses.add(expense);
  //   await _save(expenses);
  //   return expense;
  // }

  Future<void> create(ExpenseModel expense) async {
    final expenses = await fetchAll();
    expenses.add(expense);
    await _save(expenses);
  }

  // Future<ExpenseModel> update(ExpenseModel expense) async {
  //   final expenses = await fetchAll();
  //   final index = expenses.indexWhere(
  //     (e) => e.expenseId == expense.expenseId,
  //   );
  //   if (index == -1) {
  //     throw Exception(
  //       'expense ${expense.expenseId} not found.',
  //     );
  //   }
  //   expenses[index] = expense;
  //   await _save(expenses);
  //   return expense;
  // }
  Future<void> update(ExpenseModel expense) async {
    final expenses = await fetchAll();
    final index = expenses.indexWhere(
      (e) => e.expenseId == expense.expenseId,
    );
    if (index == -1) {
      throw Exception(
        'expense ${expense.expenseId} not found.',
      );
    }
    expenses[index] = expense;
    await _save(expenses);
  }

  Future<void> delete(String id) async {
    final expenses = await fetchAll();
    expenses.removeWhere(
      (expense) => expense.expenseId == int.parse(id),
    );
    await _save(expenses);
  }

  Future<void> _save(List<ExpenseModel> expenses) async {
    final encoded = jsonEncode(
      expenses.map((expense) => expense.toJson()).toList(),
    );
    await _prefs.setString(_storageKey, encoded);
  }
}
