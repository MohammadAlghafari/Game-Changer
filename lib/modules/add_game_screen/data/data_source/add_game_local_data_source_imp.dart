import 'package:game_changer/modules/shared_models/game_model.dart';

import '../../../../core/services/local_database_service.dart';
import 'add_game_local_data_source.dart';

class AddGameLocalDataSourceImp implements AddGameLocalDataSource {
  final MyDatabase _database;

  AddGameLocalDataSourceImp(this._database);

  @override
  Future<int> addGame({required GameModel model}) async {
    int id = await _database.insertOrUpdateGamesIntoDB(Game(
        id: model.id,
        title: model.title,
        maxCount: model.maxCount,
        date: model.date,
        address: model.address,
        description: model.description,
        image: model.image,
        latitude: model.latitude,
        longitude: model.longitude));
    return id;
  }
}
