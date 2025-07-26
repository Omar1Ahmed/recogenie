enum FailureType { general, server, cache, connection, validation, unauthorized, permission, timeout, rateLimit, notFound }

class Failure {
  final String message;
  final FailureType type;
  final int statusCode;
  final String? responseCode;

  const Failure({required this.message, this.type = FailureType.general, this.statusCode = 0, this.responseCode});

  const Failure.server(String msg) : this(message: msg, type:FailureType.server);
  const Failure.cache(String msg) : this(message: msg, type:FailureType.cache);
  const Failure.connection(String msg) : this(message: msg, type:FailureType.connection);
}