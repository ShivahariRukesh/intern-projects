import 'package:flutter/material.dart';

/// Base input decoration function which returns an instance of [InputDecoration]
InputDecoration inputDecoration(String label, String hint) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    filled: true,
    fillColor: const Color(0xFF1E293B),
    labelStyle: const TextStyle(color: Colors.white70),
    hintStyle: const TextStyle(color: Colors.white38),
    errorStyle: const TextStyle(
      color: Colors.redAccent,
      fontSize: 12,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 14,
      vertical: 12,
    ),
  );
}
