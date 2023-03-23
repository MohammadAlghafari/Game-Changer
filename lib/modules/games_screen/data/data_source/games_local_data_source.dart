import 'package:game_changer/modules/shared_models/game_model.dart';

/// abstract Tasks local data source class
abstract class GamesLocalDataSource {
  /// This function called to fetch all games
  /// @return List of Game Model to indicate success
  Future<List<GameModel>> getGames();

  /// This function called to delete a game
  Future<int> deleteGame(int gameId);

  /// This function called to send a whatsapp message
  Future<bool> sendMessage(String number, String message);

}
