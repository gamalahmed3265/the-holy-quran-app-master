import 'package:al_quran/presention/screens/bookmarks/bookmarks_screen.dart';
import 'package:al_quran/presention/screens/help_guide/help_guide_screen.dart';
import 'package:al_quran/presention/screens/juz/juz_index_screen.dart';
import 'package:al_quran/presention/screens/share_app/share_app_screen.dart';
import 'package:al_quran/presention/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import '../screens/onboarding/onboarding_screen.dart';

class RouterManager {
  static const String splash = "/splash";
  static const String help = "/help";
  static const String share = "/share";
  static const String intro = "/intro";
  static const String juzIndex = "/juzIndex";
  static const String bookmarks = "/bookmarks";
  static const String surahIndex = "/surahIndex";
}

class RouterGenator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouterManager.help:
        return MaterialPageRoute(builder: (_) => const HelpGuide());
      case RouterManager.bookmarks:
        return MaterialPageRoute(builder: (_) => const BookmarksScreen());
      case RouterManager.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouterManager.share:
        return MaterialPageRoute(builder: (_) => const ShareAppScreen());
      case RouterManager.intro:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RouterManager.juzIndex:
        return MaterialPageRoute(builder: (_) => const JuzIndexScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text("Not Found"),
              ),
              body: const Center(child: Text("Not Found")),
            ));
  }
}
