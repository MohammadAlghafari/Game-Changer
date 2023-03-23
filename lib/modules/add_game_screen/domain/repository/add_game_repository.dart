import 'package:dartz/dartz.dart';
import 'package:game_changer/modules/shared_entities/game_entity.dart';
import '../../../../../core/error/failures.dart';

// abstract class for Add Game Repository
abstract class AddGameRepository {
  /// This function called to add  a new game or update an exsiting one
  /// @Params 1. Game Entity [required]
  /// @return int game id to indicate success
  Future<Either<Failure, int>> addGame({required GameEntity model});
}
