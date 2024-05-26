import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/model/remote/google_maps_service/repositories/google_maps_repo.dart';
import 'package:gardenia/model/remote/google_maps_service/service/maps_api_connection.dart';
import 'package:gardenia/view_model/google_maps/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../constants/constants.dart';
import '../../modules/data_types/google_maps/ori_des_location.dart';

class MapsCubit extends Cubit<GoogleMapsStates>
{
  MapsCubit() : super(MapsInitialState());
  factory MapsCubit.getInstance(context) => BlocProvider.of(context);

  Set<Marker> markers = {};

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


  void initOurStoreMarker()
  {
    Marker ourStoreMarker = const Marker(
      infoWindow: InfoWindow(
        title: 'Gardenia Store',
      ),

      markerId: MarkerId('1'),
      position: LatLng(30.979353519902393, 31.1769525074946),
    );
    routeTrackingAppMarkers.add(ourStoreMarker);
    emit(InitMarkers());
  }

  late LocationData currentUserLocation;
  Set<Marker> routeTrackingAppMarkers = {};

  late GoogleMapController myMapCont;
  late Marker userMarker;
  Future<void> getStreamLocation({
    PlaceLocation? desLocation
})async
  {
    initOurStoreMarker();
    await location.changeSettings(
        distanceFilter: 2
    );
    location.onLocationChanged.listen((newLocationData) async{
      currentUserLocation = newLocationData;

      getRouteForLocation(
        originLocation: PlaceLocation(
          lat: newLocationData.latitude!,
          long: newLocationData.longitude!,
        ),
        desLocation: PlaceLocation(
          lat: 30.979353519902393,
          long: 31.1769525074946,
        ),
      );

      final customMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(),
        Constants.userMarker,
      );

      userMarker = Marker(
          markerId: const MarkerId('2'),
          position: LatLng(
              newLocationData.latitude!,
              newLocationData.longitude!
          ),
          icon: customMarker
      );
      routeTrackingAppMarkers.add(userMarker);
      emit(GetStreamLocationSuccess());

       await myMapCont.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(newLocationData.latitude!, newLocationData.longitude!),
        ),
      );
    });
  }


  Future<void> getStreamLocationProcess(context,{PlaceLocation? desLocation})async
  {
    bool isLocationServiceEnabled = await checkAndRequestToEnableLocationService();
    if(isLocationServiceEnabled)
      {
        await requestLocationPermission().then((permissionResult)async
        {
          if(permissionResult)
          {
            await getStreamLocation(
              desLocation: desLocation
            );
            emit(GetStreamLocationSuccess());
          }
          else
          {
            Navigator.pop(context);
          }
        });
      }
    else{
      Navigator.pop(context);
    }
  }

  GoogleMapsRepo googleMapsRepo = GoogleMapsRepo(googleMapsConnection: GoogleMapsConnection.getInstance());

  late List<LatLng> routeModel;
  Polyline? routePolyLine;
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
    ).then((getRouteResult)async
    {
      if(getRouteResult.isSuccess())
        {
          routeModel = getRouteResult.getOrThrow();
          routePolyLine = Polyline(
            polylineId: const PolylineId('1'),
            color: Colors.blue,
            points: routeModel
          );
          polyLines.add(routePolyLine!);

          Marker desMarker = Marker(
            markerId: const MarkerId('4'),
            position: LatLng(desLocation.lat, desLocation.long),
          );

          routeTrackingAppMarkers.add(desMarker);

          if(routePolyLine!.points.length < 3)
          {
            await finish();
          }
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
  late AudioPlayer player;
  Future<void> playArriveSound()async
  {
    player = AudioPlayer();
    await player.play(UrlSource('https://example.com/my-audio.wav'));
  }

  Future<void> finish()async
  {
    await playArriveSound();
    emit(FinishAndReturn());
  }
}