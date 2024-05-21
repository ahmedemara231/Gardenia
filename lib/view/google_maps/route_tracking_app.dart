import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gardenia/constants/constants.dart';
import 'package:gardenia/modules/base_widgets/divider.dart';
import 'package:gardenia/modules/base_widgets/myText.dart';
import 'package:gardenia/modules/base_widgets/textFormField.dart';
import 'package:gardenia/modules/data_types/google_maps/ori_des_location.dart';
import 'package:gardenia/modules/methods/generate_session_token.dart';
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
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<MapsCubit,GoogleMapsStates>(
        builder: (context, state) => Stack(
          children: [
            GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: (controller) {
                MapsCubit.getInstance(context).myMapCont = controller;
                MapsCubit.getInstance(context).getLocationProcess(context).then((value)
                {
                  log(MapsCubit.getInstance(context).userLocation.latitude!.toString());
                  log(MapsCubit.getInstance(context).userLocation.longitude!.toString());
                });
              },
              polylines: MapsCubit.getInstance(context).polyLines,
              markers: MapsCubit.getInstance(context).routeTrackingAppMarkers,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(0,0),
                  zoom: 14
              ),
            ),
            Positioned(
              top: 75.h,
              left: 16.w,
              right: 16.w,
              child: Column(
                children: [
                  TFF(
                    obscureText: false,
                    hintText: 'Search here',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    controller: searchCont,
                    onChanged: (searchedPlace)async
                    {
                      sessionToken ??= generateNewSessionToken();

                      log(sessionToken!);
                      await MapsCubit.getInstance(context).getSuggestions(
                        input: searchedPlace,
                        sessionToken: sessionToken!,
                      );
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
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async
                          {
                            searchCont.text = MapsCubit.getInstance(context).autoCompleteModel.predictions[index].description;

                            await MapsCubit.getInstance(context).getPlaceDetails(
                              placeId: MapsCubit.getInstance(context).autoCompleteModel.predictions[index].placeId,
                              sessionToken: sessionToken!,
                            );
                            log(sessionToken!);
                            sessionToken = null;

                            MapsCubit.getInstance(scaffoldKey.currentContext).getRouteForLocation(
                              originLocation: PlaceLocation(
                                lat: MapsCubit.getInstance(scaffoldKey.currentContext).userLocation.latitude!,
                                long: MapsCubit.getInstance(scaffoldKey.currentContext).userLocation.longitude!,
                              ),
                              desLocation: PlaceLocation(
                                lat: MapsCubit.getInstance(scaffoldKey.currentContext).placeDetailsModel.result.geometry['location']['lat'],
                                long: MapsCubit.getInstance(scaffoldKey.currentContext).placeDetailsModel.result.geometry['location']['lng'],
                              ),
                            );
                          },

                          // new context name
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.0.w,
                                vertical: 3.h
                            ),
                            child: ListTile(
                              leading: Icon(
                                  Icons.location_on_outlined,
                                  color: Constants.appColor
                              ),
                              title: MyText(
                                text: MapsCubit.getInstance(context).autoCompleteModel.predictions[index].description,
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => const MyDivider(height: 0),
                        itemCount: MapsCubit.getInstance(context).autoCompleteModel.predictions.length,
                      ),
                    ),
                  if(state is GetSuggestionsError)
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: MyText(text: state.message!)
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
