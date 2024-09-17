import 'package:equatable/equatable.dart';

class HiveException extends Equatable implements Exception {
  const HiveException({required this.message, this.statusCode = 500});

  final String message;
  final int statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}