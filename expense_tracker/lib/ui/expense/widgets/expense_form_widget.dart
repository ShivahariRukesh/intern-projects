import 'package:expense_tracker/ui/core/shared/base_form_button_widget.dart';
import 'package:expense_tracker/ui/core/shared/base_text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// It is the form widget used to input expense details
class ExpenseFormWidget extends StatelessWidget {
  /// [formKey] A global key used to identify and validate the form.
  final GlobalKey<FormState> formKey;

  /// [title] The title displayed at the top of the form.
  final String title;

  /// [buttonText] The text displayed on the submit button.
  final String buttonText;

  /// [onSubmitForm] Callback function triggered when the form is submitted.
  final void Function() onSubmitForm;

  /// [titleController] Controller used to manage the input for the expense title.
  final TextEditingController titleController;

  /// [descController] Controller used to manage the input for the expense description.
  final TextEditingController descController;

  /// [amountController] Controller used to manage the input for the expense amount.
  final TextEditingController amountController;

  /// Parameters:
  /// There are 8 named parameters:
  /// - [key]: An optional parameter that identifies the widget in the widget tree.
  /// - [formKey]: A required parameter of type GlobalKey<FormState>.
  /// - [title]: A required string parameter for the form title.
  /// - [buttonText]: A required string parameter for the submit button text.
  /// - [onSubmitForm]: A required callback function triggered on form submission.
  /// - [titleController]: A required TextEditingController for the title field.
  /// - [descController]: A required TextEditingController for the description field.
  /// - [amountController]: A required TextEditingController for the amount field.
  const ExpenseFormWidget({
    super.key,
    required this.formKey,
    required this.title,
    required this.buttonText,
    required this.onSubmitForm,
    required this.titleController,
    required this.descController,
    required this.amountController,
  });
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          BaseTextFormFieldWidget(
            controller: titleController,
            label: 'Title',
            hint: 'e.g. Lunch, Taxi',
            maxLength: 30,
            isRequired: true,
          ),

          const SizedBox(height: 16),

          BaseTextFormFieldWidget(
            controller: descController,
            label: 'Description',
            hint: 'Optional note...',
            maxLength: 100,
          ),

          const SizedBox(height: 16),
          BaseTextFormFieldWidget(
            controller: amountController,
            label: 'Amount',
            hint: 'Enter amount',
            keyboardType:
                const TextInputType.numberWithOptions(
                  decimal: true,
                ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*'),
              ),
            ],
            isRequired: true,
            prefixText: 'Rs. ',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Amount is required';
              }
              final regex = RegExp(r'^\d+(\.\d{1,2})?$');
              if (!regex.hasMatch(value)) {
                return 'Enter valid amount (e.g. 100 or 100.50)';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: BaseFormButtonWidget(
              text: buttonText,
              onPressed: () => onSubmitForm(),
            ),
          ),
        ],
      ),
    );
  }
}
