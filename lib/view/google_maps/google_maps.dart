import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gardenia/modules/app_widgets/app_button.dart';
import 'package:gardenia/view_model/google_maps/cubit.dart';
import 'package:gardenia/view_model/google_maps/states.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiffy/jiffy.dart';
import 'package:location/location.dart';

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {

  @override
  void initState() {

    MapsCubit.getInstance(context).location = Location();

    MapsCubit.getInstance(context).initOurStoreMarker();
    MapsCubit.getInstance(context).initPolyLines();

    super.initState();
  }

  @override
  void dispose() {
    MapsCubit.getInstance(context).myMapCont.dispose();
    super.dispose();
  }
  
  Future<void> initNightStyle()async
  {
    if(Jiffy.now().hour > 6)
      {
        String nightStyle = await DefaultAssetBundle.of(context).loadString('assets/map_styles/night_mode.json');
        MapsCubit.getInstance(context).myMapCont.setMapStyle(nightStyle);
      }
    else{
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<MapsCubit,GoogleMapsStates>(
            builder: (context, state) => GoogleMap(
              zoomControlsEnabled: false,
              onMapCreated: (controller)async {
                MapsCubit.getInstance(context).myMapCont = controller;
                await MapsCubit.getInstance(context).getStreamLocationProcess(context);
                // await initNightStyle();
              },
              initialCameraPosition: const CameraPosition(
                zoom: 17,
                target: LatLng(30.979237752287634, 31.176984724435957),
              ),
              markers: MapsCubit.getInstance(context).markers,
              polylines: MapsCubit.getInstance(context).polyLines,
              // cameraTargetBounds: CameraTargetBounds(
              //     LatLngBounds(
              //       northeast: ,
              //       southwest: ,
              //     ),
              // ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppButton(
                  onPressed: ()
                  {
                    MapsCubit.getInstance(context).myMapCont.animateCamera(
                      CameraUpdate.zoomIn()
                    );


                    // myMapCont.animateCamera(
                    //   CameraUpdate.newLatLngZoom(LatLng(65.9600897049099, 171.67887430746393), 5)
                    // );

                    // myMapCont.animateCamera(
                    //   CameraUpdate.newLatLng(LatLng(65.9600897049099, 171.67887430746393)),
                    // );

                    // myMapCont.animateCamera(CameraUpdate.newCameraPosition(const CameraPosition(
                    //   target: LatLng(65.9600897049099, 171.67887430746393),
                    // ),));
                  },
                  text: 'Change Position',
                  width: 3
              ),
              AppButton(
                  onPressed: ()
                  {

                    MapsCubit.getInstance(context).myMapCont.animateCamera(
                        CameraUpdate.zoomOut()
                    );

                  },
                  text: 'Change Position',
                  width: 3
              ),
            ],
          )
        ],
      )
    );
  }
}