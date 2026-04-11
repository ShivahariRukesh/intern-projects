import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/ui/views/home/home_viewmodel.dart';
import 'package:social_media_app/ui/views/home/post_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PostCardWidget extends StatelessWidget {
  final PostModel post;
  final String username;
  final _bottomSheet = locator<BottomSheetService>();
  PostCardWidget(
      {super.key,
      required this.post,
      required this.username});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          _buildImage(),
          _buildActions(),
          _buildLikeCount(),
          _buildCaption(),
          // _buildComments(),
          // _buildTimestamp(),
          const Divider(height: 15, thickness: 5),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 12, vertical: 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              'https://picsum.photos/seed/avatar_4/200/200',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Text(
            username,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          )),
          const Icon(Icons.more_horiz, size: 22),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ViewModelBuilder<PostViewModel>.reactive(
        viewModelBuilder: () => PostViewModel(),
        builder: (context, model, child) {
          return model.getPostImage(post.imageUrl!);
        });
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 4),
      child: Row(
        children: [
          const _ActionButton(icon: Icons.favorite_border),
          const SizedBox(width: 4),
          _ActionButton(
              icon: Icons.chat_bubble_outline,
              handleShowBottomSheet: () => _bottomSheet
                  .showBottomSheet(title: "All Comments")),
          const SizedBox(width: 4),
          const _ActionButton(icon: Icons.send_outlined),
          const Spacer(),
          const _ActionButton(icon: Icons.bookmark_border),
        ],
      ),
    );
  }

  Widget _buildLikeCount() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 14, vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${post.likes.toString()} likes',
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.remove_red_eye_outlined),
              Text(
                '\t\t${post.views.toString()} views',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCaption() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 2),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$username\t\t',
              style: const TextStyle(
                  fontWeight: FontWeight.w700),
            ),
            TextSpan(text: post.title),
          ],
        ),
      ),
    );
  }

  Widget _buildComments() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 2),
      child: Text(
        'View all comments',
        style: TextStyle(
            color: Colors.grey.shade600, fontSize: 14),
      ),
    );
  }

  Widget _buildTimestamp() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 2, 14, 12),
      child: Text(
        '2 hours ago',
        style: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final void Function()? handleShowBottomSheet;
  const _ActionButton(
      {required this.icon, this.handleShowBottomSheet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IconButton(
        onPressed: () => handleShowBottomSheet != null
            ? handleShowBottomSheet!()
            : null,
        icon: Icon(icon),
      ),
    );
  }
}
