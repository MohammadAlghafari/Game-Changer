import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_changer/core/error/error_message.dart';
import 'package:game_changer/core/error/failures.dart';
import 'package:game_changer/core/generic_usecase/usecase.dart';
import 'package:game_changer/modules/games_screen/data/repository/games_repository_imp.dart';
import 'package:game_changer/modules/games_screen/domain/usecase/get_games_usecase.dart';
import 'package:game_changer/modules/shared_models/game_model.dart';
import 'package:mocktail/mocktail.dart';

class MockGamesRepositoryImp extends Mock implements GamesRepositoryImp {}

void main() {
  late MockGamesRepositoryImp? mockGamesRepositoryImp;
  late GetGamesUseCase? getGamessUseCase;

  setUp(() {
    mockGamesRepositoryImp = MockGamesRepositoryImp();
    getGamessUseCase = GetGamesUseCase(mockGamesRepositoryImp!);
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
    "should return games model response when calling get games",
    () async {
      // Arrange
      when(
        () => mockGamesRepositoryImp!.getGames(),
      ).thenAnswer((invocation) async => Right(tGamesResponse));
      // Act
      final result = await getGamessUseCase!(NoParams());
      // Assert
      expect(result, Right(tGamesResponse));
      verify(
        () => mockGamesRepositoryImp!.getGames(),
      );
      verifyNoMoreInteractions(mockGamesRepositoryImp);
    },
  );
  test(
    "should return error calling get games",
    () async {
      // Arrange
      when(
        () => mockGamesRepositoryImp!.getGames(),
      ).thenAnswer((invocation) async => const Left(tErrorResponse));
      // Act
      final result = await getGamessUseCase!(NoParams());
      // Assert
      expect(result, const Left(tErrorResponse));
      verify(
        () => mockGamesRepositoryImp!.getGames(),
      );
      verifyNoMoreInteractions(mockGamesRepositoryImp);
    },
  );
}
