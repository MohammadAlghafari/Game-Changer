
import 'package:game_changer/modules/shared_models/game_model.dart';

/// abstract Add Game local data source class
abstract class AddGameLocalDataSource {
  /// This function called to add a new game or update an existing game
  /// @return int the task it to indicate success
  Future<int> addGame({required GameModel model});

}
