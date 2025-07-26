import 'failure.dart';

abstract class Result<T> {
  const Result();
}

class Success<T> extends Result<T> {
  final T data;
  final int statusCode;
  const Success({required this.data, this.statusCode = 200});
}

class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);
}