import 'package:dio/dio.dart';
import 'package:social_media_app/models/post_model.dart';
import 'package:social_media_app/utils/error_handler.dart';
import 'package:social_media_app/utils/result_record.dart';

class PostService {
  final Dio _dio = Dio(
      BaseOptions(baseUrl: 'https://dummyjson.com/posts'));

  Future<Result<List<PostModel>>> fetchAllPosts() async {
    try {
      final response = await _dio.get('/');

      final List data = response.data["posts"];
      final List<PostModel> posts = data
          .map((post) => PostModel.fromJson(post))
          .toList();

      return (
        success: SuccessResponse(data: posts),
        error: null
      );
    } on DioException catch (e) {
      return (
        success: null,
        error: ErrorResponse(message: handleDioError(e))
      );
    } catch (e) {
      print(
          "Error in post service while fetching all posts $e ");

      return (
        success: null,
        error: ErrorResponse(
            message:
                "Unexpected error occurred while fetching posts")
      );
    }
  }
}
