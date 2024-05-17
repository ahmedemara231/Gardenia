import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/view_model/google_maps/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../constants/constants.dart';

class MapsCubit extends Cubit<GoogleMapsStates>
{
  MapsCubit() : super(MapsInitialState());
  factory MapsCubit.getInstance(context) => BlocProvider.of(context);

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

  Set<Polyline> polyLines = {};
  void initPolyLines()
  {
    Polyline firstLine = const Polyline(
      width: 5,
      endCap: Cap.roundCap,
      polylineId: PolylineId('1'),
      color: Colors.red,
      points: [
        LatLng(30.81640788509372, 30.973692999151062),
        LatLng(30.120258706066462, 18.108394775410037),
      ],
    );
    polyLines.add(firstLine);
    emit(InitPolyLines());
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

  late GoogleMapController myMapCont;

  Future<void> getLocation()async
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
            emit(UserLocationSelected());
          }
          else{}
        });
      }
    else{
      Navigator.pop(context);
    }
  }
}