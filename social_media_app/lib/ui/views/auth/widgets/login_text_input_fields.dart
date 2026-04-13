import 'package:flutter/material.dart';
import 'package:social_media_app/ui/common/widgets/base_text_form_field_widget.dart';
import 'package:social_media_app/ui/views/auth/auth_view.form.dart';
import 'package:social_media_app/ui/views/auth/auth_viewmodel.dart';

class LoginTextInputFields extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final AuthViewModel viewModel;

  const LoginTextInputFields(
      {super.key,
      required this.usernameController,
      required this.passwordController,
      required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BaseTextFormFieldWidget(
        controller: usernameController,
        label: "Username",
        errorText: viewModel.usernameValidationMessage,
        prefixIcon: Icons.person_outline,
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: BaseTextFormFieldWidget(
              controller: passwordController,
              label: "Password",
              errorText:
                  viewModel.passwordValidationMessage,
              prefixIcon: Icons.lock_outline,
              obscureText: viewModel.isPasswordObscured,
              showToggle: true,
              onToggleObscure:
                  viewModel.toggleObscurePassword,
            ),
          ),
        ],
      ),
    ]);
  }
}
