import 'package:gardenia/model/remote/api_service/service/constants.dart';
import 'package:gardenia/model/remote/google_maps_service/google_maps_api_constants.dart';

String generateNewSessionToken()
{
  return MapsConstants.uuidObj!.v4();
}