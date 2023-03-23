import 'package:game_changer/modules/shared_entities/game_entity.dart';

import '../../../core/base_providers/base_provider.dart';
import '../../../core/utility/utility.dart';
import '../domain/usecase/add_game_usecase.dart';

class AddGameScreenProvider extends BaseProvider {
  final AddGameUseCase _addGameUseCase;

  AddGameScreenProvider(this._addGameUseCase);

  // Add Game function to add or update a Game
  Future<bool> addGame({required GameEntity model}) async {
    setLoading = true;
    updateUI();
    var addTaskResult =
        await _addGameUseCase(AddGameUseCaseParams(model: model));
    return addTaskResult.fold((error) {
      setError = true;
      setLoading = false;
      Utility.showToast(message: error.props.first.toString());
      updateUI();
      return false;
    }, (response) {
      setLoading = false;
      updateUI();
      return true;
    });
  }
}
