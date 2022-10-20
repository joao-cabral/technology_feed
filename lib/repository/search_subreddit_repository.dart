import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:technology_feed/model/details_model.dart';
import 'package:technology_feed/model/subreddit_model.dart';

class SearchSubredditRepository {
  Future<PostsModel?> searchSubreddit(String subreddit) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.reddit.com/r/$subreddit.json'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        PostsModel posts = PostsModel.fromJson(data);
        return posts;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
    return null;
  }

  Future<DetailsModel?> getDetails(String urlDetail) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.reddit.com$urlDetail.json'),
      );

      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        DetailsModel details = DetailsModel.fromJson(body);
        return details;
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
    return null;
  }
}
