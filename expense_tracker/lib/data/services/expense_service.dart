import 'dart:convert';
import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A service responsible for managing expense data persistence.
///
/// Uses [SharedPreferences] to store and retrieve a list of expenses
/// in JSON format. Provides basic CRUD operations for [ExpenseModel].
class ExpenseService {
  /// Storage key used to persist expense data.
  static const _storageKey = 'expense';

  final SharedPreferences _sharedPref;

  /// Creates an [ExpenseService] with the given [SharedPreferences] instance.
  ExpenseService(this._sharedPref);

  /// Fetches all stored expenses.
  ///
  /// Returns a list of [ExpenseModel]. If no data exists,
  /// an empty list is returned.
  Future<List<ExpenseModel>> fetchAll() async {
    final raw = _sharedPref.getString(_storageKey);
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

  /// Creates and stores a new [expense].
  ///
  /// The expense is appended to the existing list and persisted.
  Future<void> create(ExpenseModel expense) async {
    final expenses = await fetchAll();
    expenses.add(expense);
    await _save(expenses);
  }

  /// Updates an existing [expense].
  ///
  /// Matches the expense by its `expenseId`. Throws an [Exception]
  /// if the expense is not found.
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

  /// Deletes an expense by its [id].
  ///
  /// The [id] is expected to be a string representation of the expense ID.
  Future<void> delete(String id) async {
    final expenses = await fetchAll();

    expenses.removeWhere(
      (expense) => expense.expenseId == int.parse(id),
    );

    await _save(expenses);
  }

  /// Persists the given list of [expenses] to storage.
  ///
  /// Encodes the list into JSON and saves it using [SharedPreferences].
  Future<void> _save(List<ExpenseModel> expenses) async {
    final encoded = jsonEncode(
      expenses.map((expense) => expense.toJson()).toList(),
    );

    await _sharedPref.setString(_storageKey, encoded);
  }
}
