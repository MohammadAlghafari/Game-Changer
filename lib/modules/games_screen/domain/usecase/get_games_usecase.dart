// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';
import 'package:game_changer/modules/shared_entities/game_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/generic_usecase/usecase.dart';
import '../repository/games_repository.dart';

/// get Games useCase to link with instance from repository
///
class GetGamesUseCase extends UseCase<List<GameEntity>, NoParams> {
  final GamesRepository _gamesRepository;

  GetGamesUseCase(this._gamesRepository);

  @override
  Future<Either<Failure, List<GameEntity>>> call(NoParams params) {
    return _gamesRepository.getGames();
  }
}
