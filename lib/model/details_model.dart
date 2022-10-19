class DetailsModel {
  DetailsModel({
    required this.ups,
    this.title,
    this.body,
    this.url,
    this.comments,
    required this.author,
    this.selftext,
    this.thumbnail,
  });

  int ups;
  String? title;
  String? body;
  String? url;
  String author;
  String? selftext;
  String? thumbnail;

  List<CommentsModel>? comments;

  factory DetailsModel.fromJson(List<dynamic> json) {
    final ups = json[0]['data']['children'][0]['data']['ups'];
    final title = json[0]['data']['children'][0]['data']['title'];
    final body = json[0]['data']['children'][0]['data']['body'];
    final url = json[0]['data']['children'][0]['data']['url'];
    final author = json[0]['data']['children'][0]['data']['author'];
    final selftext = json[0]['data']['children'][0]['data']['selftext'];
    final thumbnail = json[0]['data']['children'][0]['data']['thumbnail'];
    final commentsChildren = json[1]['data']['children'];
    final List<CommentsModel> comments = [];
    for (var comment in commentsChildren) {
      comments.add(CommentsModel.fromJson(comment));
    }
    return DetailsModel(
      ups: ups,
      url: url,
      body: body,
      title: title,
      comments: comments,
      author: author,
      selftext: selftext,
      thumbnail: thumbnail,
    );
  }
}

class CommentsModel {
  CommentsModel({
    this.ups,
    this.body,
    this.url,
    required this.author,
  });
  int? ups;
  String? body;
  String? url;
  String? author;

  CommentsModel.fromJson(Map<String, dynamic> json) {
    ups = json['data']['ups'];
    body = json['data']['body'];
    url = json['data']['url'];
    author = json['data']['author'];
  }
}
