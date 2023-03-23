abstract class Failure {
  const Failure([List properties = const <dynamic>[]]) : super();
  List<Object?> get props => [];
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class ServerFailure extends Failure {
  final String message;
  const ServerFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  final String message;
  const CacheFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class AmbiguousFailure extends Failure {
  final String message;
  const AmbiguousFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class BadGateWayFailure extends Failure {
  final String message;
  const BadGateWayFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class BadRequestFailure extends Failure {
  final String message;
  const BadRequestFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class ForbiddenFailure extends Failure {
  final String message;
  const ForbiddenFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class GateWayTimeOutFailure extends Failure {
  final String message;
  const GateWayTimeOutFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class InternalServerErrorFailure extends Failure {
  final String message;
  const InternalServerErrorFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class NotFoundFailure extends Failure {
  final String message;
  const NotFoundFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class UnauthorisedFailure extends Failure {
  final String message;
  const UnauthorisedFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class TimeoutFailure extends Failure {
  final String message;
  const TimeoutFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class DefaultFailure extends Failure {
  final String message;
  const DefaultFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
