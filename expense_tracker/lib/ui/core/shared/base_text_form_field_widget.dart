import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/ui/core/shared/base_input_decoration.dart';

/// A reusable text form field for expense forms
class BaseTextFormFieldWidget extends StatelessWidget {
  /// Controller for the text field
  final TextEditingController controller;

  /// Label text for the field
  final String label;

  /// Hint text for the field
  final String hint;

  /// Maximum number of characters allowed
  final int? maxLength;

  /// Whether the field is required
  final bool isRequired;

  /// Optional custom validator
  final String? Function(String?)? validator;

  /// Input type for the keyboard
  final TextInputType keyboardType;

  /// Optional input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Prefix text
  final String? prefixText;

  const BaseTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLength,
    this.isRequired = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.prefixText,
  });

  String? _defaultValidator(String? value) {
    if (isRequired &&
        (value == null || value.trim().isEmpty)) {
      return '$label is required';
    }
    if (maxLength != null &&
        value != null &&
        value.length > maxLength!) {
      return 'Max $maxLength characters allowed';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      maxLength: maxLength,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: inputDecoration(
        label,
        hint,
      ).copyWith(prefixText: prefixText),
      validator: validator ?? _defaultValidator,
    );
  }
}
