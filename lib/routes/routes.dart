import 'package:flutter/cupertino.dart';
import 'package:technology_feed/views/details_view.dart';
import 'package:technology_feed/views/feed_view.dart';
import 'package:technology_feed/views/home_view.dart';
import 'package:technology_feed/views/scan_scanner_view.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    'home': (_) => const HomeView(),
    'feed': (_) => const FeedView(),
    'details': (_) => const DetailsView(),
    'scan_scanner': (_) => const ScanScannerView(),
  };

  // static const String splashscreen = 'splashscreen';
  static const String home = 'home';

  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
