import 'package:flutter/material.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/ui/views/home/home_viewmodel.dart';
import 'package:social_media_app/utils/shuffle_list.dart';
import 'package:stacked/stacked.dart';
import 'story_viewer_screen.dart';

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
    final postList =
        handleShuffleList<PostModel>(viewModel.postList);
    final List storyImages = List.generate(
      postList.length,
      (index) => [
        "https://picsum.photos/seed/${index + 100}/200/200",
        "https://picsum.photos/seed/${index + 100}/800/800"
      ],
    );

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: postList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StoryViewerScreen(
                    stories: storyImages,
                    initialIndex: index,
                  ),
                ),
              );
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
                            postList[index].userId] ??
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
