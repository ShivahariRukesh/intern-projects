import 'package:flutter/material.dart';
import 'package:social_media_app/ui/common/base_text_form_field_widget.dart';
import 'package:social_media_app/ui/views/auth/auth_view.form.dart';
import 'package:social_media_app/utils/auth_field_validator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import 'auth_viewmodel.dart';

@FormView(fields: [
  FormTextField(
      name: 'username',
      validator: AuthFieldValidator.validateUsername),
  FormTextField(
      name: 'password',
      validator: AuthFieldValidator.validatePassword)
])
class AuthView extends StackedView<AuthViewModel>
    with $AuthView {
  AuthView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text("Welcome Back",
                      style: theme.textTheme.titleLarge),
                  const SizedBox(height: 8),
                  const SizedBox(height: 30),
                  BaseTextFormFieldWidget(
                    controller: usernameController,
                    label: "Username",
                    errorText:
                        viewModel.usernameValidationMessage,
                    prefixIcon: Icons.person_outline,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: BaseTextFormFieldWidget(
                          controller: passwordController,
                          label: "Password",
                          errorText: viewModel
                              .passwordValidationMessage,
                          prefixIcon: Icons.lock_outline,
                          obscureText:
                              viewModel.isPasswordObscured,
                          showToggle: true,
                          onToggleObscure: viewModel
                              .toggleObscurePassword,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async =>
                          await login(viewModel),
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: viewModel
                                .hasUsernameValidationMessage
                            ? const Color.fromARGB(
                                255, 8, 38, 62)
                            : Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      child: viewModel.isBusy
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: Colors.white,
                              ),
                            )
                          : viewModel.hasError
                              ? const Text("Try Again")
                              : const Text("Login"),
                    ),
                  ),
                  if (viewModel.hasError)
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12),
                      child: Center(
                        child: Text(
                          viewModel.modelError,
                          style: TextStyle(
                              color:
                                  theme.colorScheme.error),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
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

  @override
  AuthViewModel viewModelBuilder(BuildContext context) =>
      AuthViewModel();

  @override
  void onViewModelReady(AuthViewModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(AuthViewModel viewModel) {
    super.onDispose(viewModel);
    disposeForm();
  }
}
