import 'package:flutter/material.dart';
import 'package:game_changer/modules/add_game_screen/presentation/UI/add_game_screen.dart';
import 'package:game_changer/modules/main_screen/presentation/UI/main_screen.dart';
import 'package:game_changer/routes/routes_names.dart';

import '../modules/shared_entities/game_entity.dart';

/// This Function to route manger to all screen ( handle all routing screen)
/// if you need to add a new screen should be add it here in this file.
Route<dynamic> generateRoute(RouteSettings settings) {
  Widget view;
  switch (settings.name) {
    case Routes.base:
      view = const MainScreen();
      break;
    case Routes.addGameScreen:
      view = AddGameScreen(
          game: settings.arguments != null
              ? settings.arguments as GameEntity
              : null);
      break;
    default:
      view = const Scaffold(
          body: Center(
        child: Text("Page Not Found"),
      ));
  }
  return MaterialPageRoute(builder: (context) => view, settings: settings);
}
