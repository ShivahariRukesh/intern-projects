import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_media_app/ui/views/story_screen/story_screen_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StoryScreenView
    extends StackedView<StoryScreenViewModel> {
  final List<List<String>> stories;
  final int initialIndex;
  final usernameMap;
  final List storyList;

  const StoryScreenView(
      {super.key,
      required this.stories,
      required this.initialIndex,
      required this.usernameMap,
      required this.storyList});

  @override
  void onViewModelReady(StoryScreenViewModel viewModel) {
    viewModel.init(
        stories: stories,
        initialIndex: initialIndex,
        username:
            usernameMap[storyList[initialIndex].userId] ??
                "Anonymous");
  }

  @override
  Widget builder(
    BuildContext context,
    StoryScreenViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTapUp: (details) {
        final width = MediaQuery.of(context).size.width;
        if (details.globalPosition.dx < width / 2) {
          viewModel.previousStory();
        } else {
          viewModel.nextStory(context);
        }
      },
      child: Stack(
        children: [
          PageView.builder(
            controller: viewModel.pageController,
            itemCount: viewModel.stories.length,
            onPageChanged: (int index) =>
                viewModel.onPageChanged(
                    index, usernameMap, storyList),
            itemBuilder: (context, index) {
              return SizedBox.expand(
                child: Image.network(
                  viewModel.stories[index][1],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          Positioned(
            top: 40,
            left: 8,
            right: 8,
            child: Row(
              children: List.generate(
                viewModel.stories.length,
                (index) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 2),
                    height: 3,
                    color: index <= viewModel.currentIndex
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: ClipOval(
                        child: Image.network(
                          "https://picsum.photos/seed/${Random().nextInt(100)}/200/200",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      viewModel.username,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge,
                    )
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close,
                      color: Colors.white),
                  onPressed: () => viewModel.close(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  StoryScreenViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StoryScreenViewModel();
}
