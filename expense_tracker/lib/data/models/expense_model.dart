class ExpenseModel {
  final String _title;
  final String? _description;
  final double _expenseAmount;

  ExpenseModel({
    required title,
    description,
    required expenseAmount,
  }) : _title = title,
       _description = description,
       _expenseAmount = expenseAmount;

  String get title => _title;
  String? get description => _description;
  double get expenseAmount => _expenseAmount;
}
