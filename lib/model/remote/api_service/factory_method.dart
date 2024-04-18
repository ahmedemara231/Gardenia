import 'package:dio/dio.dart';

import 'model/error_model.dart';
import 'model/model.dart';
import 'model/success_model.dart';

class Executer
{
  Model factory(Response response)
  {
    List<int> successStatusCodes = [200,201,202,203,204,205,206,207,208,226];
    List<int> clientErrorStatusCodes = [400,401,402,403,404,405,406,407,408,422,429];
    List<int> serverErrorStatusCodes = [500,501,502,503,504,505,506,507,508,410,411];

    if(successStatusCodes.contains(response.statusCode))
    {
      return SuccessModel.fromJson(response.data);
    }
    else if(clientErrorStatusCodes.contains(response.statusCode))
    {
      return ErrorModel.fromJson(response.data);
    }
    else if(serverErrorStatusCodes.contains(response.statusCode))
    {
      return ErrorModel.fromJson(response.data);
    }
    else
    {
      return ErrorModel.fromJson(response.data);
    }
  }
}