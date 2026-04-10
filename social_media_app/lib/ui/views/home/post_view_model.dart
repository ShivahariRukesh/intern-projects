import 'package:flutter/widgets.dart';
import 'package:social_media_app/app/app.locator.dart';
import 'package:social_media_app/services/image_cache_service.dart';
import 'package:stacked/stacked.dart';

class PostViewModel extends BaseViewModel {
  final _imageService = locator<ImageCacheService>();

  Widget getPostImage(String url) {
    return _imageService.loadImage(url: url);
  }
}
