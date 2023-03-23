import 'package:dartz/dartz.dart';
import 'package:game_changer/modules/shared_entities/game_entity.dart';
import 'package:game_changer/core/error/failures.dart';
import 'package:game_changer/modules/shared_models/game_model.dart';
import '../../../../../core/error/failure_error_handler.dart';
import '../../domain/repository/add_game_repository.dart';
import '../data_source/add_game_local_data_source_imp.dart';

// implementation for Add Game repository
class AddGameRepositoryImp implements AddGameRepository {
  final AddGameLocalDataSourceImp _dataSourceImp;

  AddGameRepositoryImp(this._dataSourceImp);

  @override
  Future<Either<Failure, int>> addGame({required GameEntity model}) {
    return RepoRemoteDataSourceHandler.repoDataSourceHandler(() =>
        _dataSourceImp.addGame(
            model: GameModel(
                id: model.id,
                title: model.title,
                maxCount: model.maxCount,
                date: model.date,
                address: model.address,
                description: model.description,
                image: model.image,
                latitude: model.latitude,
                longitude: model.longitude)));
  }
}
