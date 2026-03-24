import 'package:flutter/material.dart';

class ExpenseListTileWidget extends StatelessWidget {
  final int id;
  final String title;
  final String? description;
  final double amount;

  final void Function(BuildContext, int) onDeleteExpense;
  final void Function(BuildContext, Map<String, Object?>)
  onEditExpense;
  final void Function(BuildContext, Map<String, String?>)
  onViewExpenseModal;

  ExpenseListTileWidget({
    super.key,
    required this.id,
    required this.title,
    this.description,
    required this.amount,
    required this.onViewExpenseModal,
    required this.onDeleteExpense,
    required this.onEditExpense,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => onViewExpenseModal(context, {
        "id": id.toString(),
        "title": title,
        "description": description,
        "amount": amount.toString(),
      }),
      tileColor: Colors.amber.shade600,
      textColor: Colors.white,
      title: Text(title),
      leading: Text(id.toString()),

      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () => onDeleteExpense(context, id),
            icon: const Icon(Icons.delete),
          ),

          IconButton(
            onPressed: () => onEditExpense(context, {
              "id": id,
              "title": title,
              "description": description,
              "amount": amount.toString(),
            }),
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
    );
  }
}
