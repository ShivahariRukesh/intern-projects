import 'dart:math' as math;

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/ui/views/home/widgets/drawer_widget.dart';
import 'package:social_media_app/ui/views/home/widgets/home_floating_action_widget.dart';
import 'package:social_media_app/ui/views/home/widgets/post_feed_widget.dart';
import 'package:social_media_app/ui/views/home/widgets/story_list_widget.dart';
import 'package:stacked/stacked.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget builder(BuildContext context,
      HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      floatingActionButton:
          const HomeFloatingActionWidget(),
      drawer: DrawerWidget(
          loggedInUser: viewModel.loggedInUser),
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
            child: CustomMaterialIndicator(
              onRefresh: () async {
                await viewModel.getAllPost();
              },
              backgroundColor: Colors.white,
              indicatorBuilder: (context, controller) {
                return Padding(
                  padding: const EdgeInsets.all(9),
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                    value: controller.state.isLoading
                        ? null
                        : math.min(controller.value, 1),
                  ),
                );
              },
              child: ListView(
                physics:
                    const AlwaysScrollableScrollPhysics(),
                children: [
                  const StoryListWidget(),
                  PostFeedWidget(
                    posts: viewModel.postList,
                    usernameMap: viewModel.usernameMap,
                  ),
                ],
              ),
            ),
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
    viewModel.getAllPost();
    viewModel.getUserById();
  }
}
