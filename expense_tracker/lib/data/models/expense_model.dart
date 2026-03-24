class ExpenseModel {
  final int _expenseId;
  final String _title;
  final String? _description;
  final double _expenseAmount;

  ExpenseModel({
    required expenseId,
    required title,
    description,
    required expenseAmount,
  }) : _expenseId = expenseId,
       _title = title,
       _description = description,
       _expenseAmount = expenseAmount;

  int get expenseId => _expenseId;
  String get title => _title;
  String? get description => _description;
  double get expenseAmount => _expenseAmount;
}
