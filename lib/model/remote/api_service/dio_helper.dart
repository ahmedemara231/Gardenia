import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

abstract class ApiService
{
  Future<Response> get({required String endPoint,
    Map<String,dynamic>? queryParams,
    Map<String,dynamic>? headers});

  Future<Response> post({
    required String endPoint,
    required Map<String,dynamic> data,
    Map<String,dynamic>? headers
  });

  Future<Response> put({
    required String endPoint,
    required Map<String,dynamic> data,
    Map<String,dynamic>? headers
  });

  Future<Response> delete({
    required String endPoint,
    Map<String,dynamic>? data,
    Map<String,dynamic>? headers,
    Map<String,dynamic>? queryParameters,

  });
}

class DioHelper implements ApiService
{

  // DioHelper()
  // {
  //   dio = Dio(
  //     BaseOptions(
  //       baseUrl: '',
  //       connectTimeout: const Duration(seconds: 15),
  //       receiveTimeout: const Duration(seconds: 15),
  //     ),
  //   );
  // }

  late Dio dio;

  DioHelper.internal()
  {
    dio = Dio(
      BaseOptions(
        baseUrl: '',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
  }

  static DioHelper? dioHelper;

  static DioHelper getInstance()
  {
    return dioHelper ??= DioHelper.internal();
  }

  void download()async
  {
  }
  @override
  Future<Response> get({
    required String endPoint,
    Map<String,dynamic>? queryParams,
    Map<String,dynamic>? headers
})async
  {
    try{
      Response response = await dio.get(
        endPoint,
        queryParameters: queryParams,
        options: Options(
          headers: headers,
          receiveDataWhenStatusError: true,
          // responseType: ResponseType.stream,
        ),
        onReceiveProgress: (count, total)
        {
          log('total : $total');
        },
      );

      return response;
    } on Exception catch(e)
    {
      throw handleErrors(e);
    }
  }

  @override
  Future<Response> post({
    required String endPoint,
    required Map<String,dynamic> data,
    Map<String,dynamic>? headers
  })async
  {
    try{
      Response response = await dio.post(
        endPoint,
        data: data,
        options: Options(
          headers: headers,
          receiveDataWhenStatusError: true,
        ),
        onSendProgress: (count, total)
        {
          log('total : $total');
        },
      );
      return response;
    } on Exception catch(e)
    {
      throw handleErrors(e);
    }
  }

  @override
  Future<Response> put({
    required String endPoint,
    required Map<String,dynamic> data,
    Map<String,dynamic>? headers
  })async
  {
    try{
      Response response = await dio.put(
        endPoint,
        data: data,
        options: Options(
          headers: headers,
          receiveDataWhenStatusError: true,
        ),
        onSendProgress: (count, total)
        {
          log('total : $total');
        },
      );
      return response;
    } on Exception catch(e)
    {
      throw handleErrors(e);
    }
  }

  @override
  Future<Response> delete({
    required String endPoint,
    Map<String,dynamic>? data,
    Map<String,dynamic>? headers,
    Map<String,dynamic>? queryParameters,

  })async
  {
    try{
      Response response = await dio.delete(
        endPoint,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: headers,
          receiveDataWhenStatusError: true,
        ),
      );
      return response;
    } on Exception catch(e)
    {
      throw handleErrors(e);
    }
  }

  String handleErrors(Exception e)
  {
    String errorMessage = '';

    if(e is DioException)
    {
      switch(e.type)
      {
        case DioExceptionType.badResponse:
          log('bad response');
          errorMessage = 'bad response';
          log('${e.response?.statusCode} && ${e.response?.statusMessage}');

        case DioExceptionType.connectionError:
        case DioExceptionType.connectionTimeout:
          log('connection error');
          errorMessage = 'Check internet Connection and Try again';
          log('${e.response?.statusCode} && ${e.response?.statusMessage}');

        case DioExceptionType.receiveTimeout:
          log('receive timeout');
          errorMessage = 'Check internet Connection and Try again';
          log('${e.response?.statusCode} && ${e.response?.statusMessage}');

        case DioExceptionType.cancel:
          log('response canceled');
          errorMessage = 'response Canceled';
          log('${e.response?.statusCode} && ${e.response?.statusMessage}');
        case DioExceptionType.unknown:
          errorMessage = 'unknown';
          log('${e.response?.statusCode} && ${e.response?.statusMessage}');

        default:
          log('default');
          errorMessage = 'Try again later';
          log('${e.response?.statusCode} && ${e.response?.statusMessage}');
      }
    }
    else
    {
      if(e is SocketException)
      {
        errorMessage = 'Check internet Connection and Try again';
        log(e.message);
      }
      else{
        errorMessage = 'Try again later';
      }
    }
    return errorMessage;
  }
}

