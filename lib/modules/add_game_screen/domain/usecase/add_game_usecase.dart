import 'package:dartz/dartz.dart';
import 'package:game_changer/modules/shared_entities/game_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/generic_usecase/usecase.dart';
import '../repository/add_game_repository.dart';

/// Add Task useCase to link with instance from repository
///
class AddGameUseCase extends UseCase<int, AddGameUseCaseParams> {
  final AddGameRepository _addGameRepository;

  AddGameUseCase(this._addGameRepository);

  @override
  Future<Either<Failure, int>> call(AddGameUseCaseParams params) {
    return _addGameRepository.addGame(model: params.model);
  }
}

class AddGameUseCaseParams {
  final GameEntity model;
  AddGameUseCaseParams({
    required this.model,
  });
}
