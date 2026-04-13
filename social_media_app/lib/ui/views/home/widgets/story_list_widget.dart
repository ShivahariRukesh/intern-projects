import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/app/app.router.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/ui/views/home/home_viewmodel.dart';
import 'package:social_media_app/utils/shuffle_list.dart';
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
  Widget build(
      BuildContext context, HomeViewModel viewModel) {
    final storyList = viewModel.storyList;
    final List<List<String>> storyImages = List.generate(
      storyList.length,
      (index) => [
        "https://picsum.photos/seed/${index + 100}/200/200",
        "https://picsum.photos/seed/${index + 100}/800/800"
      ],
    );

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: storyList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              locator<NavigationService>()
                  .navigateToStoryScreenView(
                      stories: storyImages,
                      initialIndex: index,
                      usernameMap: viewModel.usernameMap,
                      storyList: storyList);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              Colors.red,
                              Colors.blue,
                              Colors.yellow
                            ]),
                        borderRadius:
                            BorderRadius.circular(100)),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          storyImages[index][0]),
                      radius: 25,
                    ),
                  ),
                  Text(
                    viewModel.usernameMap[
                            storyList[index].userId] ??
                        '...',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
