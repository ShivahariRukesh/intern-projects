import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class StoryScreenViewModel extends BaseViewModel {
  late PageController pageController;
  late List<List<String>> stories;
  late int currentIndex;
  String username = "Anonymous";
  void init(
      {required List<List<String>> stories,
      required int initialIndex,
      required String username}) {
    this.stories = stories;
    currentIndex = initialIndex;
    this.username = username;
    pageController =
        PageController(initialPage: currentIndex);
  }

  void onPageChanged(int index, usernameMap, storyList) {
    currentIndex = index;
    username =
        usernameMap[storyList[index].userId] ?? "Anonymous";
    notifyListeners();
  }

  void nextStory(BuildContext context) {
    if (currentIndex < stories.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pop(context);
    }
  }

  void previousStory() {
    if (currentIndex > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void close(BuildContext context) {
    Navigator.pop(context);
  }
}
