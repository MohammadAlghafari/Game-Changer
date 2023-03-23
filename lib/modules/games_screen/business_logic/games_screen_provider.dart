import 'package:game_changer/modules/games_screen/domain/usecase/delete_game_usecase.dart';
import 'package:game_changer/modules/games_screen/domain/usecase/send_message_usecase.dart';
import 'package:game_changer/modules/shared_entities/game_entity.dart';

import '../../../core/base_providers/base_provider.dart';
import '../../../core/generic_usecase/usecase.dart';
import '../../../core/utility/utility.dart';
import '../domain/usecase/get_games_usecase.dart';

class GamesScreenProvider extends BaseProvider {
  final GetGamesUseCase _getGamesUseCase;
  final DeleteGameUseCase _deleteGameUseCase;
  final SendMessageUseCase _sendMessageUseCase;
  GamesScreenProvider(
      this._getGamesUseCase, this._deleteGameUseCase, this._sendMessageUseCase);

  List<GameEntity> _games = [];
  List<GameEntity> get games => _games;

  bool _sortByTitle = true;
  bool get sortByTitle => _sortByTitle;

  bool _sortByDate = false;
  bool get sortByDate => _sortByDate;

  void sortGamesByTitle() {
    _sortByTitle = true;
    _sortByDate = false;
    _games.sort((a, b) => a.title.compareTo(b.title));
    updateUI();
  }

  void sortGamesByDate() {
    _sortByTitle = false;
    _sortByDate = true;
    _games.sort((a, b) => a.date.compareTo(b.date));
    updateUI();
  }

  // get Games function to get all games
  Future<bool> getGames() async {
    setLoading = true;
    setError = false;
    updateUI();
    var gamesResult = await _getGamesUseCase(NoParams());
    return gamesResult.fold((error) {
      setError = true;
      setLoading = false;
      Utility.showToast(message: error.props.first.toString());
      updateUI();
      return false;
    }, (response) {
      setLoading = false;
      _games = response;
      updateUI();
      return true;
    });
  }

  // delete game function to delete a specific game
  Future<bool> deleteGame(int gameId) async {
    setError = false;
    updateUI();
    var deleteResult =
        await _deleteGameUseCase(DeleteGameUseCaseParams(gameId: gameId));
    return deleteResult.fold((error) {
      Utility.showToast(message: error.props.first.toString());
      return false;
    }, (response) {
      getGames();
      return true;
    });
  }

  // send message function to ssend a whatsapp message to a number
  Future<bool> sendMessage(String number, String message) async {
    setError = false;
    updateUI();
    var messageResult = await _sendMessageUseCase(
        SendMessageUseCaseParams(number: number, message: message));
    return messageResult.fold((error) {
      Utility.showToast(message: error.props.first.toString());
      return false;
    }, (response) {
      if (response) {
        return true;
      } else {
        return false;
      }
    });
  }
}
