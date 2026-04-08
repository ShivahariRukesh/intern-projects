import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context,
      HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Social Me'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sunny),
            onPressed: () => viewModel.toggleTheme(),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => viewModel.handleLogout(),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: viewModel.isBusy
                ? const CircularProgressIndicator()
                : Column(children: [
                    const Text("Welcome back!!"),
                    Text(viewModel.loggedInUser?.username ??
                        'Unknown User')
                  ]),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) =>
      HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    viewModel.getLoggedInUser();
  }
}
