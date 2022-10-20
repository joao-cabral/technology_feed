import 'package:flutter/material.dart';
import 'package:technology_feed/model/details_model.dart';
import 'package:technology_feed/model/subreddit_model.dart';
import 'package:technology_feed/repository/search_subreddit_repository.dart';

class SubredditController extends ChangeNotifier {
  SearchSubredditRepository subredditRepository = SearchSubredditRepository();
  PostsModel? data = PostsModel();
  DetailsModel? details;
  TextEditingController controllerSearchSubreddit =
      TextEditingController(text: 'FlutterDev');
  String urlDetails = '';
  bool isLoading = false;
  bool isValid = true;

  Future<String> searchSubreddit() async {
    isLoading = true;
    notifyListeners();

    await subredditRepository
        .searchSubreddit(controllerSearchSubreddit.text)
        .then((value) => data = value);

    isLoading = false;
    notifyListeners();

    return data != null ? 'success' : 'error';
  }

  Future<String> getDetails() async {
    isLoading = true;
    notifyListeners();

    await subredditRepository
        .getDetails(urlDetails)
        .then((value) => details = value);

    isLoading = false;
    notifyListeners();
    return details != null ? 'success' : 'error';
  }

  void searchIsValid() {
    if (controllerSearchSubreddit.text == 'FlutterDev' ||
        controllerSearchSubreddit.text.isNotEmpty) {
      isValid = true;
      notifyListeners();
      return;
    }
    isValid = false;
    notifyListeners();
    return;
  }
}
