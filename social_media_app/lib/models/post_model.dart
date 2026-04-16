class PostModel {
  final int id;
  final int userId;
  final String title;
  final String? imageUrl;
  final int likes;
  final int views;

  PostModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.imageUrl,
      required this.likes,
      required this.views});

  factory PostModel.fromJson(Map<String, dynamic> filteredJsonData) {
    return PostModel(
        id: filteredJsonData["id"] as int,
        userId: filteredJsonData["userId"] as int,
        title: filteredJsonData["title"] as String,
        imageUrl: filteredJsonData["imageUrl"] as String? ?? '',
        likes: filteredJsonData["reactions"]["likes"] as int,
        views: filteredJsonData["views"] as int);
  }
}
