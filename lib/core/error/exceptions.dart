class ServerException implements Exception {
  final String message;
  const ServerException({required this.message});
}

class CacheException implements Exception {
  final String message;
  const CacheException({required this.message});
}

class AmbiguousException implements Exception {
  final String message;
  const AmbiguousException({required this.message});
}

class BadGateWayException implements Exception {
  final String message;
  const BadGateWayException({required this.message});

}

class BadRequestException implements Exception {
  final String message;
  const BadRequestException({required this.message});

}

class ForbiddenException implements Exception {
  final String message;
  const ForbiddenException({required this.message});

}

class GateWayTimeOutException implements Exception {
  final String message;
  const GateWayTimeOutException({required this.message});

}

class InternalServerErrorException implements Exception {
  final String message;
  const InternalServerErrorException({required this.message});

}

class NotFoundException implements Exception {
  final String message;
  const NotFoundException({required this.message});
}

class UnauthorisedException implements Exception {
  final String message;
  const UnauthorisedException({required this.message});

}

class TimeoutException implements Exception {
  final String message;
  const TimeoutException({required this.message});
}

class DefaultException implements Exception {
  final String message;
  const DefaultException({required this.message});
}