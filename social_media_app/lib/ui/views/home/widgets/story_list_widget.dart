import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Story {
  final String imageUrl;
  Story({required this.imageUrl});
}

class StoryListWidget
    extends ViewModelWidget<HomeViewModel> {
  const StoryListWidget({super.key});

  @override
  bool get reactive => true;

  @override
  Widget build(
      BuildContext context, HomeViewModel viewModel) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.storyList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () =>
                _handleStoryListTap(index, viewModel),
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  _storyImage(viewModel.storyImages, index),
                  _storyUsername(viewModel,
                      viewModel.storyList, index, context)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Text _storyUsername(
      HomeViewModel viewModel,
      List<PostModel> storyList,
      int index,
      BuildContext context) {
    return Text(
      viewModel.usernameMap[storyList[index].userId] ??
          '...',
      style: Theme.of(context).textTheme.bodySmall,
    );
  }

  Container _storyImage(
      List<List<String>> storyImages, int index) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Colors.red,
            Colors.blue,
            Colors.yellow
          ]),
          borderRadius: BorderRadius.circular(100)),
      child: CircleAvatar(
        backgroundImage:
            NetworkImage(storyImages[index][0]),
        radius: 25,
      ),
    );
  }

  void _handleStoryListTap(
      int index, HomeViewModel viewModel) {
    locator<NavigationService>().navigateToStoryScreenView(
        stories: viewModel.storyImages,
        initialIndex: index,
        usernameMap: viewModel.usernameMap,
        storyList: viewModel.storyList);
  }
}
