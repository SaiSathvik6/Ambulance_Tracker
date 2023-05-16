import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPage();
}

class OrderTrackingPageState extends StateOrdertrackingPage> {
  final Completer<GooglemapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(coorrdinates)
  static const LatLng destination = LatLng(coordinates);
  
  List<LatLng> polylineCoordinates = [];
  LocationDate? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;



  void getCurrentLocation() async {
    Location location = Location();


    location.getLocation().then(
      (location){
        currentLocation = location;
      },
    );

    GoogleMapController googleMapController = await  _controller.future;


    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;

        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
              target: LatLng(
                newLoc.latitude!, 
                newLoc.longitude!,
              ),
            ),//Lating //CameraPosition
          ),
        );

        setState(() {});
      },
    );
  }

  void getPolyPoints() async {
    PolyLinePoints polylinePoints = PolyLinePoints();

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = polylinePoints.getRouteBetweenCoordinates
      google_api_key;
      PointLating(sourceLocation.latitude, sourceLocation.longitude),
      PointLating(destination.latitude,destination.longitude),
    );

    if(result.points.isNotEmpty){
      result.points.forEach(
        (PointLating point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
      setState(() {});
    }
  }

  void setCustomMarkerIcon(){
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_source.png")
          .then(
            (icon) {
              sourceIcon = icon;
      },
    );

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_destination.png")
          .then(
            (icon) {
              destinationIcon = icon;
      },
    );

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Badge.png")
          .then(
            (icon) {
              currentLocation = icon;
      },
    );
  }
  

  @override
  void initState(){
    getCurrentLocation();
    setCustomMarkerIcon();
    getPolyPoints();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const text(
          "Track order",
          style: TextStyle(color: Colors.black, fontsize: 16),
        ),
      ),
      body: currentLocation == null 
      ? const Center (child: Text("Loading"))
      : GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              currentLocation!.latiude! , currentLocation.longitude
            ), 
            zoom: 13.5
          ), // CameraPosition
          polylines: {
            Polylines: (
              polylineId: PolylineId("route"),
              points: polylineCoordinates,
              color: primaryColor,
              width: 6,
            ),//Polyline
          },
        markers: {
          Marker(
            markerId: const MarkerId("currentLocation"),
            icon: currentLocation
            position: LatLng(
              currentLocation!.latitude!, currentLocation.longitude),
          ),//Marker
          Marker(
            markerId: MarkerId("source"),
            icon: sourceIcon,
            position: sourceLocation, 
          ), 
          Marker(
            markerId: MarkerId("destination"),
            icon = destinationIcon,
            position: destination, 
          ), 
        },
        onMapCreated: (mapController) {
          _controller.complete(mapController);
        },
      ), //GoogleMap
    )

  }


}
