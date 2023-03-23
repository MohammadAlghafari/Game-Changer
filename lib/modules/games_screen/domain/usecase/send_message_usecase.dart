// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/generic_usecase/usecase.dart';
import '../repository/games_repository.dart';

/// Send message useCase to send whatsapp message to the provided number
class SendMessageUseCase extends UseCase<bool, SendMessageUseCaseParams> {
  final GamesRepository _gamesRepository;

  SendMessageUseCase(this._gamesRepository);

  @override
  Future<Either<Failure, bool>> call(SendMessageUseCaseParams params) {
    return _gamesRepository.sendMessage(params.number, params.message);
  }
}

class SendMessageUseCaseParams {
  final String number;
  final String message;
  SendMessageUseCaseParams({
    required this.number,
    required this.message,
  });
}
