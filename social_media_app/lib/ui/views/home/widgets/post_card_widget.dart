import 'package:flutter/material.dart';
import 'package:social_media_app/app/app.bottomsheets.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/ui/views/home/post_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PostCardWidget extends StatelessWidget {
  final PostModel post;
  final String username;
  final _bottomSheet = locator<BottomSheetService>();
  PostCardWidget({super.key, required this.post, required this.username});

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
          const Divider(height: 15, thickness: 5),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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

  // Widget _buildImage() {
  //   return ViewModelBuilder<PostViewModel>.reactive(
  //       viewModelBuilder: () => PostViewModel(),
  //       builder: (context, model, child) {
  //         return model.getPostImage(post.imageUrl!);
  //       });
  // }

  Widget _buildImage() {
    return ViewModelBuilder<PostViewModel>.reactive(
      viewModelBuilder: () => PostViewModel(),
      builder: (context, model, child) {
        return _AnimatedPostImage(
          child: model.getPostImage(post.imageUrl!),
        );
      },
    );
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
              handleShowBottomSheet: () => _bottomSheet.showCustomSheet(
                  title: "All Comments", variant: BottomSheetType.comment)),
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
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
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
          const Text(
            '200 comments',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const Text(
            '122 shares',
            style: TextStyle(
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
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            TextSpan(text: post.title),
          ],
        ),
      ),
    );
  }
}

// class _ActionButton extends StatelessWidget {
//   final IconData icon;
//   final void Function()? handleShowBottomSheet;
//   const _ActionButton(
//       {required this.icon, this.handleShowBottomSheet});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8),
//       child: IconButton(
//         onPressed: () => handleShowBottomSheet != null
//             ? handleShowBottomSheet!()
//             : null,
//         icon: Icon(icon),
//       ),
//     );
//   }
// }
class _ActionButton extends StatefulWidget {
  final IconData icon;
  final void Function()? handleShowBottomSheet;

  const _ActionButton({
    required this.icon,
    this.handleShowBottomSheet,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  bool isLiked = false;

  bool get isLikeButton =>
      widget.icon == Icons.favorite_border || widget.icon == Icons.favorite;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scale = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.3)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween:
            Tween(begin: 1.3, end: 1.0).chain(CurveTween(curve: Curves.easeIn)),
        weight: 50,
      ),
    ]).animate(_controller);
  }

  void _onTap() {
    // Handle like toggle ONLY for heart button
    if (isLikeButton) {
      setState(() {
        isLiked = !isLiked;
      });

      _controller.forward(from: 0);
    }

    // Keep your existing bottom sheet logic
    if (widget.handleShowBottomSheet != null) {
      widget.handleShowBottomSheet!();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconData = isLikeButton
        ? (isLiked ? Icons.favorite : Icons.favorite_border)
        : widget.icon;

    final iconColor = isLikeButton && isLiked ? Colors.red : Colors.black;

    return ScaleTransition(
      scale: _scale,
      child: IconButton(
        onPressed: _onTap,
        icon: Icon(
          iconData,
          color: iconColor,
        ),
      ),
    );
  }
}

class _AnimatedPostImage extends StatefulWidget {
  final Widget child;

  const _AnimatedPostImage({required this.child});

  @override
  State<_AnimatedPostImage> createState() => _AnimatedPostImageState();
}

class _AnimatedPostImageState extends State<_AnimatedPostImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: widget.child,
    );
  }
}
