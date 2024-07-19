import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/view_model/google_maps/cubit.dart';
import 'package:gardenia/view_model/google_maps/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../modules/app_widgets/arrow_back_button.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  late TextEditingController searchCont;
  String? sessionToken;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    MapsCubit.getInstance(context).location = Location();
    searchCont = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    MapsCubit.getInstance(context).myMapCont.dispose();
    searchCont.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const ArrowBackButton(),
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<MapsCubit,GoogleMapsStates>(
        builder: (context, state) => Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                MapsCubit.getInstance(context).myMapCont = controller;
                MapsCubit.getInstance(context).getStreamLocationProcess(context);
              },
              polylines: MapsCubit.getInstance(context).polyLines,
              markers: MapsCubit.getInstance(context).routeTrackingAppMarkers,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(0,0),
                  zoom: 16
              ),
            ),
          ],
        ),
      ),
    );
  }
}
