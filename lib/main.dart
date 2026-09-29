import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

/// Set the first time a visitor sees the terminal intro, so returning visitors
/// land straight on the content.
const _introSeenKey = 'intro_seen';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Resolved before the first frame rather than in initState: deciding later
  // would either flash the intro at a returning visitor or flash the hero at a
  // first-time one.
  var showIntro = true;
  try {
    final prefs = await SharedPreferences.getInstance();
    showIntro = !(prefs.getBool(_introSeenKey) ?? false);
    if (showIntro) {
      await prefs.setBool(_introSeenKey, true);
    }
  } catch (_) {
    // Private browsing and blocked site data make storage throw. Falling back
    // to playing the intro keeps the site working; it just is not remembered.
  }

  runApp(ProviderScope(child: PortfolioApp(showIntro: showIntro)));
}
