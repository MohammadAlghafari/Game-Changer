import 'package:dartz/dartz.dart';
import '../../../../../core/error/failure_error_handler.dart';
import '../../../../core/error/failures.dart';
import '../../../shared_entities/game_entity.dart';
import '../../domain/repository/games_repository.dart';
import '../data_source/games_local_data_source_imp.dart';

// implementation for Games repository
class GamesRepositoryImp implements GamesRepository {
  final GamesLocalDataSourceImp _dataSourceImp;

  GamesRepositoryImp(this._dataSourceImp);

  @override
  Future<Either<Failure, List<GameEntity>>> getGames() {
    return RepoRemoteDataSourceHandler.repoDataSourceHandler(
        () => _dataSourceImp.getGames());
  }

  @override
  Future<Either<Failure, int>> deleteGame(int gameId) {
    return RepoRemoteDataSourceHandler.repoDataSourceHandler(
        () => _dataSourceImp.deleteGame(gameId));
  }
  
  @override
  Future<Either<Failure, bool>> sendMessage(String number, String message) {
    return RepoRemoteDataSourceHandler.repoDataSourceHandler(
        () => _dataSourceImp.sendMessage(number, message));
  }
}
