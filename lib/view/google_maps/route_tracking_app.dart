import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/model/remote/api_service/repositories/google_maps_repo.dart';
import 'package:gardenia/modules/base_widgets/divider.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/view_model/google_maps/cubit.dart';
import 'package:gardenia/view_model/google_maps/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class RouteTrackingApp extends StatefulWidget {
  const RouteTrackingApp({super.key});

  @override
  State<RouteTrackingApp> createState() => _RouteTrackingAppState();
}

class _RouteTrackingAppState extends State<RouteTrackingApp> {

  late TextEditingController searchCont;

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
      body: BlocBuilder<MapsCubit,GoogleMapsStates>(
        builder: (context, state) => Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                MapsCubit.getInstance(context).myMapCont = controller;
                MapsCubit.getInstance(context).getLocationProcess(context);
              },
              markers: MapsCubit.getInstance(context).routeTrackingAppMarkers,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(0,0),
                  zoom: 14
              ),
            ),
            Positioned(
              top: 40.h,
              left: 16.w,
              right: 16.w,
              child: Column(
                children: [
                  TFF(
                    obscureText: false,
                    hintText: 'Search here',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    controller: searchCont,
                    onChanged: (searchedPlace)
                    {
                      MapsCubit.getInstance(context).getSuggestions(searchedPlace);
                    },
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),

                  if(state is GetSuggestionsSuccess)
                    ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => MyText(
                        text: MapsCubit.getInstance(context).mapModel.predictions[index].description,
                        color: Colors.red,
                      ),
                      separatorBuilder: (context, index) => const MyDivider(),
                      itemCount: MapsCubit.getInstance(context).mapModel.predictions.length,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
