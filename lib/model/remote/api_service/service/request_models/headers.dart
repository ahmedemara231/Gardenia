import 'dart:io';
import 'package:gardenia/model/remote/stripe/api_service/constants.dart';

import '../../../../local/secure_storage.dart';

abstract class RequestHeaders
{
  String contentType;
  String accept;

  RequestHeaders({
    this.contentType = 'application/json',
    this.accept  = 'application/json',
  });

  Future<Map<String,dynamic>> toJson();
}

class HeadersWithToken extends RequestHeaders
{
  HeadersWithToken({super.contentType});

  Future<String?> get _getToken async
  {
    String? token = 'Bearer ${await SecureStorage.getInstance().readData(key: 'userToken')}';
    return token;
  }

  @override
  Future<Map<String, dynamic>> toJson()async {
    return
      {
        HttpHeaders.contentTypeHeader : accept,
        HttpHeaders.acceptHeader : contentType,
        HttpHeaders.authorizationHeader : await _getToken,
      };
  }
}

class HeadersWithoutToken extends RequestHeaders
{
  HeadersWithoutToken({super.contentType});

  @override
  Future<Map<String, dynamic>> toJson()async {
    return
      {
        HttpHeaders.contentTypeHeader : accept,
        HttpHeaders.acceptHeader : contentType,
      };
  }
}

class StripeHeaders extends RequestHeaders
{
  final stripeVersion;

  StripeHeaders({required super.contentType,this.stripeVersion});

  Map<String,dynamic> get _getHeaders
  {
    return
      {
        HttpHeaders.authorizationHeader : StripeApiConstants.tokenSecretKey,
        HttpHeaders.contentTypeHeader : contentType,
        'Stripe-Version' : stripeVersion,
      };
  }

  @override
  Future<Map<String, dynamic>> toJson()async
  {
    return _getHeaders;
  }
}