import 'package:flutter/services.dart';

class EasyUpiPaymentException implements Exception {
  final EasyUpiPaymentExceptionType type;
  final String? message;
  final dynamic details;
  final String? stacktrace;

  EasyUpiPaymentException({
    required this.type,
    required this.message,
    required this.details,
    required this.stacktrace,
  });

  factory EasyUpiPaymentException.fromException(PlatformException exception) {
    EasyUpiPaymentExceptionType type;

    switch (exception.code) {
      case 'Cancelled':
        type = EasyUpiPaymentExceptionType.cancelledException;
        break;
      case 'Failure':
        type = EasyUpiPaymentExceptionType.failedException;
        break;
      case 'Submitted':
        type = EasyUpiPaymentExceptionType.submittedException;
        break;
      default:
        type = EasyUpiPaymentExceptionType.unknownException;
        break;
    }

    return EasyUpiPaymentException(
      type: type,
      message: exception.message,
      details: exception.details,
      stacktrace: exception.stacktrace,
    );
  }
}

enum EasyUpiPaymentExceptionType {
  /// when transaction is cancelled by the user.
  cancelledException,

  /// when transaction failed
  failedException,

  /// Transaction is in PENDING state. Money might get deducted from user’s account but not yet deposited in payee’s account.
  submittedException,

  /// when unknown exception occurs
  unknownException,
}
