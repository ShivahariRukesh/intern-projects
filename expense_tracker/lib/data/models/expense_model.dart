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

  Map<String, dynamic> toJson() => {
    'id': expenseId,
    'title': title,
    'description': description,
    'amount': expenseAmount,
  };

  int get expenseId => _expenseId;
  String get title => _title;
  String? get description => _description;
  double get expenseAmount => _expenseAmount;
}
