import 'package:expense_tracker/data/models/expense_model.dart';
import 'package:expense_tracker/ui/expense/widgets/expense_form_widget.dart';
import 'package:flutter/material.dart';

/// It is the base form widget for creating or editing an expense
class BaseFormWidget extends StatefulWidget {
  /// [titleText] The title text displayed at the top of the form.
  final String titleText;

  /// [buttonText] The text displayed on the form submission button.
  final String buttonText;

  /// [onSubmit] Callback function triggered when the form is submitted.
  /// It provides the current [BuildContext], title, description, and amount.
  final void Function(BuildContext, String, String, double)
  onSubmit;

  /// [initialData] Optional map containing initial values for the form fields.
  final ExpenseModel? initialData;

  /// Parameters:
  /// There are 5 named parameters:
  /// - [key]: An optional parameter that identifies the widget in the widget tree.
  /// - [titleText]: A required string parameter for the form title.
  /// - [buttonText]: A required string parameter for the submit button text.
  /// - [onSubmit]: A required callback function triggered on form submission.
  /// - [initialData]: An optional parameter providing initial form data which is of [ExpenseModel] data type.
  BaseFormWidget({
    super.key,
    required this.titleText,
    required this.buttonText,
    required this.onSubmit,
    this.initialData,
  });

  @override
  State<BaseFormWidget> createState() =>
      _BaseFormWidgetState();
}

class _BaseFormWidgetState extends State<BaseFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _titleController.text =
          widget.initialData!.title as String? ?? '';
      _descController.text =
          widget.initialData!.description ?? '';
      _amountController.text = widget
          .initialData!
          .expenseAmount
          .toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom:
            MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF0F172A),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: ExpenseFormWidget(
          formKey: _formKey,
          title: widget.titleText,
          buttonText: widget.buttonText,
          onSubmitForm: onSubmitForm,
          titleController: _titleController,
          descController: _descController,
          amountController: _amountController,
        ),
      ),
    );
  }

  void onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final desc = _descController.text.trim();
      final amt = double.parse(_amountController.text);
      widget.onSubmit(context, title, desc, amt);
      Navigator.pop(context);
    }
  }
}
