import 'package:flutter/material.dart';
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
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: "Username",
                      errorText: viewModel
                              .usernameValidationMessage ??
                          "",
                      prefixIcon:
                          const Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: viewModel
                              .passwordValidationMessage ??
                          "",
                      prefixIcon:
                          const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => loginUser(viewModel),
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

  void loginUser(AuthViewModel viewModel) {
    if (!viewModel.isBusy &&
        !viewModel.hasUsernameValidationMessage) {
      viewModel.loginUser();
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
