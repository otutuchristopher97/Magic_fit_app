import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure({required this.message, required this.statusCode})
      : assert(
          statusCode is String || statusCode is int,
          'StatusCode cannot be a ${statusCode.runtimeType}',
        );

  final String message;
  final dynamic statusCode;

  String get errorMessage {
    final showErrorText =
        statusCode is! String || int.tryParse(statusCode as String) != null;
    return '$statusCode${showErrorText ? ' Error' : ''}: $message';
  }

  @override
  List<dynamic> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, required super.statusCode});
}

class DatabaseFailure extends Failure {
  DatabaseFailure({required super.message, required super.statusCode});

  DatabaseFailure.fromException(DatabaseFailure exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}
