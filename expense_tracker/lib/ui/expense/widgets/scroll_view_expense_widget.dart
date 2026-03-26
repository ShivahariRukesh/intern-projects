import 'package:flutter/material.dart';

/// It is the scroll view widget to see the current expense details
class ScrollViewExpenseWidget extends StatelessWidget {
  /// [isSmall] Determines whether the widget should render in a compact (small screen)
  /// or expanded (larger screen) layout.
  final bool isSmall;

  /// [title] The title or name of the expense.
  final String title;

  /// [description]  A brief description providing more context about the expense which can be null as it is optional.
  final String? description;

  /// [amount] The monetary value associated with the expense.
  final double amount;

  /// Parameters:
  /// There are 5 named parameters:
  /// - [key] : An optional parameter that identifies widget in the widget tree
  /// - [isSmall]: Required parameter that has bool as data type.
  /// - [title]: A String type required parameter.
  /// - [description]: A String type optional parameter.
  /// - [amount]: A double data type required parameter.
  const ScrollViewExpenseWidget({
    super.key,
    required this.isSmall,
    required this.title,
    this.description,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _closeIconWidget(context),
          SizedBox(height: isSmall ? 6 : 8),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: isSmall ? 10 : 12),
          _showExpenseDescriptionWidget(),
          SizedBox(height: isSmall ? 14 : 16),
          _showExpenseAmountWidget(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Row _showExpenseAmountWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Expense Amount',
          style: TextStyle(
            color: Colors.white54,
            fontSize: isSmall ? 13 : 14,
          ),
        ),
        Flexible(
          child: Text(
            'Rs. $amount',
            style: const TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Align _closeIconWidget(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        icon: Icon(
          Icons.close_rounded,
          color: Colors.white70,
          size: isSmall ? 20 : 24,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _showExpenseDescriptionWidget() {
    if (description != null) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(isSmall ? 10 : 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          description ?? '',
          style: TextStyle(
            color: Colors.white70,
            fontSize: isSmall ? 13 : 14,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
