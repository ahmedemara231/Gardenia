import 'dart:developer';

class CustomError implements Exception
{
  String? message;

  CustomError(this.message)
  {
    log(message??'error');
  }
}

class NetworkError extends CustomError {
  NetworkError(super.message);
}

class BadResponseError extends CustomError {
  BadResponseError(super.message);
}

class BadRequestError extends CustomError {
  BadRequestError(super.message);
}

class UnAuthorizedError extends CustomError {
  UnAuthorizedError(super.message);
}

class NotFoundError extends CustomError {
  NotFoundError(super.message);
}

class ConflictError extends CustomError {
  ConflictError(super.message);
}

class UnprocessableEntityError extends CustomError {
  UnprocessableEntityError(super.message);
}

class BadCertificateError extends CustomError {
  BadCertificateError(super.message);
}

class CancelError extends CustomError {
  CancelError(super.message);
}

class UnknownError extends CustomError {
  UnknownError(super.message);
}