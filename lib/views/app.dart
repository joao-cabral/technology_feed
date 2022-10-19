import 'package:flutter/material.dart';
import 'package:technology_feed/routes/routes.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'What\'s the news?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: Routes.list,
      initialRoute: Routes.home,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
