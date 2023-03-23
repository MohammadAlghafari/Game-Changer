import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_changer/core/error/error_message.dart';
import 'package:game_changer/core/error/exceptions.dart';
import 'package:game_changer/core/error/failures.dart';
import 'package:game_changer/modules/games_screen/data/data_source/games_local_data_source_imp.dart';
import 'package:game_changer/modules/games_screen/data/repository/games_repository_imp.dart';
import 'package:game_changer/modules/shared_models/game_model.dart';
import 'package:mocktail/mocktail.dart';

class MockGamesLocalDataSourceImp extends Mock
    implements GamesLocalDataSourceImp {}

void main() {
  late MockGamesLocalDataSourceImp? mockGamesLocalDataSourceImp;
  late GamesRepositoryImp? gamesRepositoryImp;

  setUp(() {
    mockGamesLocalDataSourceImp = MockGamesLocalDataSourceImp();
    gamesRepositoryImp = GamesRepositoryImp(mockGamesLocalDataSourceImp!);
  });

  final tGamesResponse = [
    GameModel(
        id: 1,
        title: 'title',
        maxCount: 1,
        date: '12/1/2024',
        address: 'Al Barsha 1',
        description: ' a good game',
        image: '',
        latitude: '43.535',
        longitude: '34.21t6')
  ];

  const tErrorResponse = CacheFailure(message: ErrorMessages.nDefault);

  test(
    "get games should return games respons emodel",
    () async {
      // Arrange
      when(() => mockGamesLocalDataSourceImp!.getGames())
          .thenAnswer((_) async => tGamesResponse);
      // Act
      final result = await gamesRepositoryImp!.getGames();
      // Assert
      expect(result, Right(tGamesResponse));
      verify(() => mockGamesLocalDataSourceImp!.getGames());
      verifyNoMoreInteractions(mockGamesLocalDataSourceImp);
    },
  );
  test(
    "get games should return error form get games",
    () async {
      // Arrange
      when(() => mockGamesLocalDataSourceImp!.getGames())
          .thenThrow(const CacheException(message: ErrorMessages.nDefault));
      // Act
      final result = await gamesRepositoryImp!.getGames();
      // Assert
      expect(result, const Left(tErrorResponse));
      verify(() => mockGamesLocalDataSourceImp!.getGames());
      verifyNoMoreInteractions(mockGamesLocalDataSourceImp);
    },
  );
}
