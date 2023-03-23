import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:game_changer/core/services/local_database_service.dart';
import 'package:game_changer/modules/shared_models/game_model.dart';

import '../../../../constants/consts/consts.dart';
import '../../../../core/error/generic_exceptions_handler.dart';
import 'games_local_data_source.dart';

class GamesLocalDataSourceImp implements GamesLocalDataSource {
  final MyDatabase _database;
  final Dio _dio;

  GamesLocalDataSourceImp(this._database, this._dio);

  @override
  Future<List<GameModel>> getGames() async {
    var games = await _database.getGamesFromDB();
    return games.map((e) => GameModel.fromLocalDataBase(e)).toList();
  }

  @override
  Future<int> deleteGame(int gameId) async {
    return await _database.deleteGameFromDB(gameId);
  }

  @override
  Future<bool> sendMessage(String number, String message) async {
    Response? response;
    String url =
        'https://api.twilio.com/2010-04-01/Accounts/${Consts.twilioAccountSid}/Messages.json';

    String creds = '${Consts.twilioAccountSid}:${Consts.twilioAauthToken}';
    var bytes = utf8.encode(creds);
    var base64Str = base64.encode(bytes);

    try {
      var headers = {
        'Authorization': 'Basic $base64Str',
      };
      final params = {
        'To': 'whatsapp:$number',
        'From': 'whatsapp:${Consts.twilioNumber}',
        'Body': message,
      };
      response = await _dio.post(
        url,
        data: params,
        options: Options(
            headers: headers, contentType: Headers.formUrlEncodedContentType),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw customExceptionHandler(response);
    }
  }
}
