import 'package:dartz/dartz.dart';

import 'error_message.dart';
import 'exceptions.dart';
import 'failures.dart';

class RepoRemoteDataSourceHandler<T> {
  static Future<Either<Failure, T>> repoDataSourceHandler<T>(
      Future<T> Function() function) async {
    try {
      return Right(await function());
    } on ServerException catch (server) {
      return Left(ServerFailure(message: server.message));
    } on CacheException catch (cache) {
      return Left(CacheFailure(message: cache.message));
    } on AmbiguousException catch (ambiguous) {
      return Left(AmbiguousFailure(message: ambiguous.message));
    } on BadGateWayException catch (badGateWay) {
      return Left(BadGateWayFailure(message: badGateWay.message));
    } on BadRequestException catch (badRequest) {
      return Left(BadRequestFailure(message: badRequest.message));
    } on ForbiddenException catch (forbidden) {
      return Left(ForbiddenFailure(message: forbidden.message));
    } on GateWayTimeOutException catch (gateWayTimeOut) {
      return Left(GateWayTimeOutFailure(message: gateWayTimeOut.message));
    } on InternalServerErrorException catch (internalServer) {
      return Left(InternalServerErrorFailure(message: internalServer.message));
    } on NotFoundException catch (notFound) {
      return Left(NotFoundFailure(message: notFound.message));
    } on UnauthorisedException catch (unauthorised) {
      return Left(UnauthorisedFailure(message: unauthorised.message));
    } on TimeoutException catch (timeoutException) {
      return Left(TimeoutFailure(message: timeoutException.message));
    } on DefaultException catch (defaultException) {
      return Left(DefaultFailure(message: defaultException.message));
    } catch (e) {
      return const Left(ServerFailure(message: ErrorMessages.nDefault));
    }
  }
}
