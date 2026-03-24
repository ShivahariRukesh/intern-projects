import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable input field widget.
///
/// [BaseInputFieldWidget] wraps a [TextField] with additional features such as
/// a prefix icon, label, hint, error message, suffix text, and input formatting.
/// It is designed to be reusable for forms and other user input scenarios.
class BaseInputFieldWidget extends StatelessWidget {
  /// [controller] controls the text being edited.
  final TextEditingController controller;

  /// [label] is an optional text displayed above the input field.
  final String? label;

  /// [hint] is an optional placeholder text shown inside the input field.
  final String? hint;

  /// [errorText] is an optional error message displayed below the input field.
  final String? errorText;

  /// [suffixText] is an optional text displayed at the end of the input field.
  final String? suffixText;

  /// [icon] is displayed at the start of the input field as a visual cue.
  final IconData icon;

  /// [keyboardType] defines the type of keyboard to use for input.
  final TextInputType keyboardType;

  /// [inputFormatters] are optional formatters applied to the text input.
  final List<TextInputFormatter>? inputFormatters;

  /// Creates a [BaseInputFieldWidget] widget.
  ///
  /// [controller], [icon], and [keyboardType] are required.
  /// All other parameters are optional.
  const BaseInputFieldWidget({
    super.key,
    required this.controller,
    required this.icon,
    required this.keyboardType,
    this.label,
    this.hint,
    this.errorText,
    this.suffixText,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          style: Theme.of(context).textTheme.displayMedium,
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            prefixIcon: Icon(icon),
            labelText: label,
            hintText: hint,
            suffixText: suffixText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        _errorText(),
      ],
    );
  }

  Widget _errorText() {
    if (errorText != null) {
      return Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(
          errorText!,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 12,
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
