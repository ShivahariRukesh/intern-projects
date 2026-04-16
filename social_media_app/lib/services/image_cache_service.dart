import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCacheService {
  Widget loadImage({
    required String url,
    BoxFit fit = BoxFit.cover,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      placeholder: (context, url) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
