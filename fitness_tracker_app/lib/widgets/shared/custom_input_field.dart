import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable input field widget.
///
/// [CustomInputField] wraps a [TextField] with additional features such as
/// a prefix icon, label, hint, error message, suffix text, and input formatting.
/// It is designed to be reusable for forms and other user input scenarios.
///
/// [controller] controls the text being edited.
///
/// [icon] is displayed at the start of the input field as a visual cue.
///
/// [keyboardType] defines the type of keyboard to use for input.
///
/// [label] is an optional text displayed above the input field.
///
/// [hint] is an optional placeholder text shown inside the input field.
///
/// [errorText] is an optional error message displayed below the input field.
///
/// [suffixText] is an optional text displayed at the end of the input field.
///
/// [inputFormatters] are optional formatters applied to the text input.
class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final String? suffixText;
  final IconData icon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  /// Creates a [CustomInputField] widget.
  ///
  /// [controller], [icon], and [keyboardType] are required.
  /// All other parameters are optional.
  const CustomInputField({
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

        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
