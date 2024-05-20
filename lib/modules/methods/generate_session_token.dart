import 'package:gardenia/model/remote/api_service/service/constants.dart';

String generateNewSessionToken()
{
  return ApiConstants.uuidObj!.v4();
}