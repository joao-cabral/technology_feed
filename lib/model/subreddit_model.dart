class PostsModel {
  PostsModel({
    this.posts,
  });

  List<PostModel>? posts;

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
        posts: List<PostModel>.from(
          json["data"]["children"].map(
            (post) => PostModel.fromJson(post),
          ),
        ),
      );
}

class PostModel {
  PostModel({
    this.title,
    this.name,
    this.score,
    this.thumbnail,
    this.numComments,
    this.author,
    this.url,
    this.permalink,
  });

  String? title;
  String? name;
  int? score;
  String? thumbnail;
  int? numComments;
  String? author;
  String? url;
  String? permalink;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        title: json["data"]["title"],
        name: json["data"]["name"],
        score: json["data"]["score"],
        thumbnail: json["data"]["thumbnail"],
        numComments: json["data"]["num_comments"],
        author: json["data"]["author"],
        url: json["data"]["url"],
        permalink: json["data"]["permalink"],
      );
}
