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

  const ExpenseListTileWidget({
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
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => onViewExpenseModal(context, {
        'id': id.toString(),
        'title': title,
        'description': description,
        'amount': amount.toString(),
      }),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF334155),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            /// LEFT ICON / ID
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: const Color(
                  0xFF6366F1,
                ).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                id.toString(),
                style: const TextStyle(
                  color: Color(0xFF818CF8),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 12),

            /// TITLE + DESCRIPTION
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (description != null &&
                      description!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        description!,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rs. ${amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// EDIT
                    GestureDetector(
                      onTap: () => onEditExpense(context, {
                        'id': id,
                        'title': title,
                        'description': description,
                        'amount': amount.toString(),
                      }),
                      child: const Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(width: 10),

                    /// DELETE
                    GestureDetector(
                      onTap: () =>
                          onDeleteExpense(context, id),
                      child: const Icon(
                        Icons.delete,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
