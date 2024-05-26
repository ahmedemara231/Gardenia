import 'dart:developer';

class GoogleMapsError implements Exception
{
  String? message;

  GoogleMapsError(this.message)
  {
    log(message??'error');
  }
}

class NetworkError extends GoogleMapsError {
  NetworkError(super.message);
}

class BadResponseError extends GoogleMapsError {
  BadResponseError(super.message);
}

class BadRequestError extends GoogleMapsError {
  BadRequestError(super.message);
}