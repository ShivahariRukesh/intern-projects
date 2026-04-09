import 'package:dio/dio.dart';
import 'package:social_media_app/models/post_model.dart';

class PostService {
  final Dio _dio = Dio(
      BaseOptions(baseUrl: 'https://dummyjson.com/posts'));

  Future<List<PostModel>> fetchAllPosts() async {
    try {
      final response = await _dio.get('/');

      final List data = response.data["posts"];
      print("length is ${data.length}");
      final List<PostModel> posts = data
          .map((post) => PostModel.fromJson(post))
          .toList();

      return posts;
    } catch (e) {
      print(
          "Error in post service while fetching all posts $e ");
      rethrow;
    }
  }
}
