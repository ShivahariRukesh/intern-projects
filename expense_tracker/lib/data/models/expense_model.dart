/// A data model representing a single expense entry.
///
/// Encapsulates  id, title, optional description, and amount.
class ExpenseModel {
  final int _expenseId;
  final String _title;
  final String? _description;
  final double _expenseAmount;

  /// Creates an [ExpenseModel] instance.
  ///
  /// Requires a unique [expenseId], a [title], and an [expenseAmount].
  /// The [description] field is optional.
  ExpenseModel({
    required expenseId,
    required title,
    description,
    required expenseAmount,
  }) : _expenseId = expenseId,
       _title = title,
       _description = description,
       _expenseAmount = expenseAmount;

  /// Creates an [ExpenseModel] from a JSON map.
  ///
  /// Expects keys:
  /// - `id` for expense ID
  /// - `title` for expense title
  /// - `description` for optional details
  /// - `amount` for expense value
  factory ExpenseModel.fromJson(
    Map<String, dynamic> jsonData,
  ) {
    return ExpenseModel(
      expenseId: jsonData['id'],
      title: jsonData['title'],
      description: jsonData['description'],
      expenseAmount: jsonData['amount'],
    );
  }

  /// Converts the [ExpenseModel] instance into a JSON map.
  ///
  /// Useful for storing or transmitting expense data.
  Map<String, dynamic> toJson() => {
    'id': expenseId,
    'title': title,
    'description': description,
    'amount': expenseAmount,
  };

  /// Returns the unique identifier of the expense.
  int get expenseId => _expenseId;

  /// Returns the title of the expense.
  String get title => _title;

  /// Returns the optional description of the expense.
  String? get description => _description;

  /// Returns the monetary amount of the expense.
  double get expenseAmount => _expenseAmount;
}
