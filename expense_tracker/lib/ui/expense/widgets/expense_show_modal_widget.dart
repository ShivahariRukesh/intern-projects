import 'package:flutter/material.dart';

class ExpenseShowModalWidget extends StatelessWidget {
  final Map<String, Object?> _currentExpenseDetail;

  const ExpenseShowModalWidget(
    this._currentExpenseDetail, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final isSmall = size.width < 400;

    final title =
        (_currentExpenseDetail['title'] ?? '') as String;
    final description =
        (_currentExpenseDetail['description'] ?? '')
            as String;
    final amount = _currentExpenseDetail['amount'];

    return Dialog(
      backgroundColor: Colors.transparent,

      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 450),

        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A),
            borderRadius: BorderRadius.circular(20),
          ),

          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: Colors.white70,
                      size: isSmall ? 20 : 24,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                SizedBox(height: isSmall ? 6 : 8),

                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      "#${_currentExpenseDetail["id"]}",
                      style: TextStyle(
                        color: Colors.white38,
                        fontWeight: FontWeight.bold,
                        fontSize: isSmall ? 12 : 14,
                      ),
                    ),
                    const SizedBox(width: 10),

                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: isSmall ? 10 : 12),

                if (description.isNotEmpty)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(
                      isSmall ? 10 : 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: Text(
                      description,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: isSmall ? 13 : 14,
                      ),
                    ),
                  ),

                SizedBox(height: isSmall ? 14 : 16),

                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: isSmall ? 13 : 14,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "Rs. ${amount ?? "0"}",
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
