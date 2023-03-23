// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/generic_usecase/usecase.dart';
import '../repository/games_repository.dart';

/// Delete Game useCase to link with instance from repository
class DeleteGameUseCase extends UseCase<int, DeleteGameUseCaseParams> {
  final GamesRepository _gamesRepository;

  DeleteGameUseCase(this._gamesRepository);

  @override
  Future<Either<Failure, int>> call(DeleteGameUseCaseParams params) {
    return _gamesRepository.deleteGame(params.gameId);
  }
}

class DeleteGameUseCaseParams {
  final int gameId;
  DeleteGameUseCaseParams({
    required this.gameId,
  });
}
