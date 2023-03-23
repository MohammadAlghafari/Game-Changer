import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_changer/core/error/error_message.dart';
import 'package:game_changer/core/error/failures.dart';
import 'package:game_changer/core/generic_usecase/usecase.dart';
import 'package:game_changer/modules/games_screen/business_logic/games_screen_provider.dart';
import 'package:game_changer/modules/games_screen/domain/usecase/delete_game_usecase.dart';
import 'package:game_changer/modules/games_screen/domain/usecase/get_games_usecase.dart';
import 'package:game_changer/modules/games_screen/domain/usecase/send_message_usecase.dart';
import 'package:game_changer/modules/shared_entities/game_entity.dart';
import 'package:mocktail/mocktail.dart';

class MockGetGamesUseCase extends Mock implements GetGamesUseCase {}

class MockDeleteGameUseCase extends Mock implements DeleteGameUseCase {}

class MockSendMessageUseCase extends Mock implements SendMessageUseCase {}

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGetGamesUseCase? mockGetGamesUseCase;
  late MockDeleteGameUseCase? mockDeleteGameUseCase;
  late MockSendMessageUseCase? mockSendMessageUseCase;
  late GamesScreenProvider? gamesScreenProvider;
  late NoParams noParams;
  setUp(() {
    mockGetGamesUseCase = MockGetGamesUseCase();
    mockDeleteGameUseCase = MockDeleteGameUseCase();
    mockSendMessageUseCase = MockSendMessageUseCase();
    gamesScreenProvider = GamesScreenProvider(
        mockGetGamesUseCase!, mockDeleteGameUseCase!, mockSendMessageUseCase!);
    noParams = NoParams();
    registerFallbackValue(noParams);
  });

  final tGamesResponse = [
    GameEntity(
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

  group('test get games functionality in provider', () {
    test(
      "initial values of provider should be correct",
      () async {
        // Assert
        expect(gamesScreenProvider!.isLoading, false);
        expect(gamesScreenProvider!.isError, false);
      },
    );

    test(
      "should call get games usecase and get data back",
      () async {
        // Arrange
        when(() => mockGetGamesUseCase!(any()))
            .thenAnswer((_) async => Right(tGamesResponse));
        when(() => mockGetGamesUseCase!(any()))
            .thenAnswer((_) async => Right(tGamesResponse));
        // Act
        await gamesScreenProvider!.getGames();
        // Assert
        expect(gamesScreenProvider!.games.isNotEmpty, true);
        verify(() => mockGetGamesUseCase!(any()));
      },
    );

    test(
      "should call get games usecase and get error",
      () async {
        // Arrange
        when(() => mockGetGamesUseCase!(any()))
            .thenAnswer((_) async => const Left(tErrorResponse));
        // Act
        await gamesScreenProvider!.getGames();
        // Assert
        expect(gamesScreenProvider!.games.isEmpty, true);
        expect(gamesScreenProvider!.isError, true);
        verify(() => mockGetGamesUseCase!(any()));
      },
    );
  });
}
