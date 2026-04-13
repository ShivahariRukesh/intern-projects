import 'package:flutter/material.dart';

class _HomeFabAction {
  final IconData icon;
  final String label;
  const _HomeFabAction(
      {required this.icon, required this.label});
}

const homeFabActions = [
  _HomeFabAction(icon: Icons.photo_camera, label: 'Photo'),
  _HomeFabAction(icon: Icons.videocam, label: 'Video'),
  _HomeFabAction(icon: Icons.auto_awesome, label: 'Story'),
  _HomeFabAction(
      icon: Icons.article_outlined, label: 'Post'),
];
