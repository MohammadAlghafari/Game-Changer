import 'package:dartz/dartz.dart';
import 'package:game_changer/modules/shared_entities/game_entity.dart';
import '../../../../../core/error/failures.dart';

// abstract class for Tasks Repository
abstract class GamesRepository {
  /// This function called to fetch all games
  /// @return List of Game Entity to indicate success
  Future<Either<Failure, List<GameEntity>>> getGames();

  // this function called to delete a game
  Future<Either<Failure, int>> deleteGame(int gameId);

  // this function called to send whatsapp message to the given number
  Future<Either<Failure, bool>> sendMessage(String number, String message);
}
