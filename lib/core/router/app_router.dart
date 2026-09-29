import 'package:flutter/material.dart';

import '../../features/home/presentation/pages/home_page.dart';

abstract final class AppRouter {
  static Route<dynamic> onGenerateRoute(
    RouteSettings settings, {
    bool showIntro = true,
  }) {
    switch (settings.name) {
      case '/':
      default:
        return MaterialPageRoute<void>(
          builder: (_) => HomePage(showIntro: showIntro),
          settings: settings,
        );
    }
  }
}
