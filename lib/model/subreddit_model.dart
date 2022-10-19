class ResponseModel {
  ResponseModel({
    this.data,
  });

  String? kind;
  ResponseModelData? data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
        data: ResponseModelData.fromJson(json["data"]),
      );
}

class ResponseModelData {
  ResponseModelData({
    this.after,
    required this.dist,
    this.modhash,
    this.geoFilter,
    this.children,
    this.before,
  });

  dynamic after;
  int dist;
  String? modhash;
  String? geoFilter;
  List<Child>? children;
  String? before;

  factory ResponseModelData.fromJson(Map<String, dynamic> json) =>
      ResponseModelData(
        after: json["after"],
        dist: json["dist"],
        modhash: json["modhash"],
        geoFilter: json["geo_filter"],
        children:
            List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
        before: json["before"],
      );
}

class Child {
  Child({
    this.data,
  });

  ChildData? data;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        data: ChildData.fromJson(json["data"]),
      );
}

class ChildData {
  ChildData({
    this.title,
    this.name,
    this.score,
    this.thumbnail,
    this.likes,
    this.numComments,
    this.author,
    this.url,
    this.permalink,
  });

  String? title;
  String? name;
  int? score;
  String? thumbnail;
  dynamic likes;
  int? numComments;
  String? author;
  String? url;
  String? permalink;

  factory ChildData.fromJson(Map<String, dynamic> json) => ChildData(
        title: json["title"],
        name: json["name"],
        score: json["score"],
        thumbnail: json["thumbnail"],
        likes: json["likes"],
        numComments: json["num_comments"],
        author: json["author"],
        url: json["url"],
        permalink: json["permalink"],
      );
}
