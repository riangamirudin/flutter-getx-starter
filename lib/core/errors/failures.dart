/// Base class untuk semua failure
abstract class Failure {
  final String message;

  const Failure(this.message);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure && runtimeType == other.runtimeType && message == other.message;

  @override
  int get hashCode => message.hashCode;
}

/// Failure untuk server error
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Failure untuk network error
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

/// Failure untuk cache error
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// Failure untuk validation error
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Failure untuk authentication error
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Failure untuk permission error
class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

/// Failure untuk unknown error
class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

