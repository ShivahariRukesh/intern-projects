import 'package:flutter/material.dart';

class BaseTextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? errorText;
  final IconData prefixIcon;
  final bool obscureText;
  final VoidCallback? onToggleObscure;
  final bool showToggle;

  const BaseTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    this.errorText,
    required this.prefixIcon,
    this.obscureText = false,
    this.onToggleObscure,
    this.showToggle = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        errorText: errorText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: showToggle
            ? IconButton(
                onPressed: onToggleObscure,
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
