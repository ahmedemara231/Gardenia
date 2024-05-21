import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/model/remote/google_maps_service/google_maps_models/route_model.dart';
import 'package:gardenia/model/remote/google_maps_service/repositories/google_maps_repo.dart';
import 'package:gardenia/model/remote/google_maps_service/maps_api_connection.dart';
import 'package:gardenia/view_model/google_maps/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../constants/constants.dart';
import '../../model/remote/google_maps_service/google_maps_models/autoCompleteModel.dart';
import '../../model/remote/google_maps_service/google_maps_models/place_details.dart';
import '../../modules/data_types/google_maps/ori_des_location.dart';

class MapsCubit extends Cubit<GoogleMapsStates>
{
  MapsCubit() : super(MapsInitialState());
  factory MapsCubit.getInstance(context) => BlocProvider.of(context);

  String name = 'aaaa';
  Set<Marker> markers = {};
  Future<void> initOurStoreMarker()async
  {
    // final customMarker = await BitmapDescriptor.fromAssetImage(
    //   const ImageConfiguration(),
    //   Constants.userMarker,
    // );
    //
    // Marker myLocationMarker = Marker(
    //     markerId: const MarkerId('1'),
    //     position: const LatLng(30.979237752287634, 31.176984724435957),
    //     infoWindow: const InfoWindow(title: 'Test'),
    //     icon: customMarker
    // );
    // markers.add(myLocationMarker);
    //
    // emit(InitMarkers());
  }

  late Location location;

  // check enabling location service in settings
  Future<bool> checkAndRequestToEnableLocationService()async
  {
    bool isLocationServiceEnabled = await location.serviceEnabled();
    if(isLocationServiceEnabled)
    {
      return true;
    }
    else{
      bool isEnabledNow = await location.requestService();
      return isEnabledNow;
    }
  }

  // request for access location
  Future<bool> requestLocationPermission()async
  {
    PermissionStatus hasPermission = await location.hasPermission();
    if(hasPermission == PermissionStatus.denied)
    {
      PermissionStatus requestPermissionResult = await location.requestPermission();
      return requestPermissionResult == PermissionStatus.granted;
    }
    else{
      return true;
    }
  }



  late LocationData userLocation;
  Set<Marker> routeTrackingAppMarkers = {};
  Future<void> getLocation()async
  {
     await location.getLocation().then((userLocationData)
    {
      LatLng userLatLng = LatLng(userLocationData.latitude!, userLocationData.longitude!);
      Marker userLocationMarker = Marker(
        markerId: const MarkerId('3'),
        position: userLatLng
      );

      routeTrackingAppMarkers.add(userLocationMarker);
      myMapCont.animateCamera(
          CameraUpdate.newLatLng(
              userLatLng
          ),
      );
      userLocation = userLocationData;
      return userLocationData;
    });
  }

  late GoogleMapController myMapCont;

  Future<void> getStreamLocation()async
  {
    await location.changeSettings(
        distanceFilter: 2
    );
    location.onLocationChanged.listen((newLocationData) async{

      final customMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        Constants.userMarker,
      );

      Marker userMarker = Marker(
          markerId: const MarkerId('2'),
          position: LatLng(newLocationData.latitude!, newLocationData.longitude!),
          icon: customMarker
      );
      markers.add(userMarker);

       await myMapCont.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(newLocationData.latitude!, newLocationData.longitude!),
        ),
      );
    });
  }



  Future<void> getStreamLocationProcess(context)async
  {
    bool isLocationServiceEnabled = await checkAndRequestToEnableLocationService();
    if(isLocationServiceEnabled)
      {
        await requestLocationPermission().then((permissionResult)async
        {
          if(permissionResult)
          {
            await getStreamLocation();
            emit(GetStreamLocationSuccess());
          }
          else{return;}
        });
      }
    else{
      Navigator.pop(context);
    }
  }
  Future<void> getLocationProcess(context)async
  {
    bool isLocationServiceEnabled = await checkAndRequestToEnableLocationService();
    if(isLocationServiceEnabled)
    {
      await requestLocationPermission().then((permissionResult)async
      {
        if(permissionResult)
        {
          await getLocation();
          emit(GetLocationSuccess());
        }
        else{}
      });
    }
    else{
      Navigator.pop(context);
    }
  }
  
  GoogleMapsRepo googleMapsRepo = GoogleMapsRepo(googleMapsConnection: GoogleMapsConnection.getInstance());
  late AutoCompleteModel autoCompleteModel;
  Future<void> getSuggestions({
    required String input,
    required String sessionToken,
})async
  {
    emit(GetSuggestionsLoading());

    if(input.isEmpty)
      {
        autoCompleteModel.predictions.clear();
        emit(ClearSuggestionsList());
      }
    else{
      await googleMapsRepo.getSuggestions(
        input: input,
        sessionToken: sessionToken
      ).then((suggestionsResult)
      {
        if(suggestionsResult.isSuccess())
          {
            autoCompleteModel = suggestionsResult.getOrThrow();
            emit(GetSuggestionsSuccess());
          }
        else{
          emit(
              GetSuggestionsError(
                  message: suggestionsResult.tryGetError()?.message
              ),
          );
        }
      });
    }
  }

  late PlaceDetailsModel placeDetailsModel;
  Future<void> getPlaceDetails({
    required String placeId,
    required String sessionToken,
})async
  {
    emit(GetPlaceDetailsLoading());

    await googleMapsRepo.getPlaceDetails(
        placeId: placeId,
        sessionToken: sessionToken
    ).then((getDetailsResult)
    {
      if(getDetailsResult.isSuccess())
        {
          placeDetailsModel = getDetailsResult.getOrThrow();
          emit(GetPlaceDetailsSuccess());
        }
      else{
        emit(
            GetPlaceDetailsError(
              message: getDetailsResult.tryGetError()?.message
            ),
        );
      }
    });
  }



  late List<LatLng> routeModel;
  late Polyline routePolyLine;
  Set<Polyline> polyLines = {};
  Future<void> getRouteForLocation({
    required PlaceLocation originLocation,
    required PlaceLocation desLocation,
  })async
  {
    emit(GetLocationRouteLoading());
    await googleMapsRepo.getRoute(
        originLocation: originLocation,
        desLocation: desLocation
    ).then((getRouteResult)
    {
      if(getRouteResult.isSuccess())
        {
          routeModel = getRouteResult.getOrThrow();
          routePolyLine = Polyline(
            polylineId: const PolylineId('1'),
            color: Colors.blue,
            points: routeModel
          );
          polyLines.add(routePolyLine);
          emit(GetLocationRouteSuccess());
        }
      else{
        emit(
            GetLocationRouteError(
              message: getRouteResult.tryGetError()?.message
            )
        );
      }
    });
  }
}