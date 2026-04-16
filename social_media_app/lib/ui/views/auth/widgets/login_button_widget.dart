import 'package:flutter/material.dart';
import 'package:social_media_app/ui/views/auth/auth_view.form.dart';
import 'package:social_media_app/ui/views/auth/auth_viewmodel.dart';

class LoginButtonWidget extends StatelessWidget {
  final AuthViewModel viewModel;
  const LoginButtonWidget(
      {super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () async => await login(viewModel),
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor:
              viewModel.hasUsernameValidationMessage
                  ? const Color.fromARGB(255, 8, 38, 62)
                  : Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: viewModel.isBusy
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : viewModel.hasError
                ? const Text("Try Again")
                : const Text("Login"),
      ),
    );
  }

  Future<void> login(AuthViewModel viewModel) async {
    if (!viewModel.isBusy &&
        !viewModel.hasUsernameValidationMessage &&
        !viewModel.hasPasswordValidationMessage &&
        viewModel.usernameValue != "" &&
        viewModel.passwordValue != "") {
      await viewModel.loginUser();
    }
  }
}
