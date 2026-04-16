import 'package:flutter/material.dart';
import 'package:social_media_app/ui/views/auth/auth_view.form.dart';
import 'package:social_media_app/ui/views/auth/widgets/login_button_widget.dart';
import 'package:social_media_app/ui/views/auth/widgets/login_text_input_fields.dart';
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
                  _loginTitle(theme),
                  const SizedBox(height: 30),
                  LoginTextInputFields(
                      usernameController:
                          usernameController,
                      passwordController:
                          passwordController,
                      viewModel: viewModel),
                  const SizedBox(height: 30),
                  LoginButtonWidget(viewModel: viewModel),
                  _loginErrorText(viewModel, theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Text _loginTitle(ThemeData theme) {
    return Text("Welcome Back",
        style: theme.textTheme.titleLarge);
  }

  Widget _loginErrorText(
      AuthViewModel viewModel, ThemeData theme) {
    if (viewModel.hasError) {
      return Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Center(
          child: Text(
            viewModel.modelError,
            style:
                TextStyle(color: theme.colorScheme.error),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
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
