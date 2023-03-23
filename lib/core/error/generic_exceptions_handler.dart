import 'package:dio/dio.dart';

import '../../constants/api_keys/api_keys.dart';
import '../error/exceptions.dart';
import 'error_message.dart';

// Custom Exception Handler to handle all status codes that is returned from the backend



Exception customExceptionHandler<T>(Response? response) {

  if (response == null){
    throw const DefaultException(message:ErrorMessages.nDefault);
  }else {
    switch (response.statusCode) {
      case 300:
        throw AmbiguousException(message:response.data[ApiKeys.message][0]);
      case 502:
        throw const BadGateWayException(message:ErrorMessages.nDefault);
      case 400:
        throw BadRequestException(message:response.data[ApiKeys.message][0]);
      case 403:
        throw ForbiddenException(message:response.data[ApiKeys.message][0]);
      case 504:
        throw GateWayTimeOutException(message:response.data[ApiKeys.message][0]);
      case 500:
        throw InternalServerErrorException(message:response.data[ApiKeys.message][0]);
      case 404:
        throw NotFoundException(message:response.data[ApiKeys.message][0]);
      case 401:
        throw UnauthorisedException(message:response.data[ApiKeys.message][0]);
      case 408:
        throw TimeoutException(message:response.data[ApiKeys.message][0]);
      default:
        throw const DefaultException(message:ErrorMessages.nDefault);
    }
  }
}