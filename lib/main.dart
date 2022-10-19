import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technology_feed/controllres/subreddit_controller.dart';
import 'package:technology_feed/views/app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SubredditController>(
          create: (context) => SubredditController(),
        )
      ],
      child: const MyApp(),
    ),
  );
}
