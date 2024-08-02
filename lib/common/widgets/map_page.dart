

// // // import 'dart:async';
// // // import 'dart:math';

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // // import 'package:location/location.dart';
// // // import 'package:shop/constants/global_variables.dart';

// // // class MapPage extends StatefulWidget {
// // //   const MapPage({super.key});

// // //   @override
// // //   State<MapPage> createState() => MapPageState();
// // // }

// // // class MapPageState extends State<MapPage> {
// // //   final Completer<GoogleMapController> _controller = Completer();

// // //   Location locationController = new Location();

// // //   static const LatLng sourceLocation=LatLng(37.33500926, -122.03272188);
// // //   static const LatLng destinationLocation=LatLng(37.33429383, -122.06600055);

// // //   List<LatLng> polylineCoordinates = [];

// // //   void getPolyPoints() async{
// // //     PolylinePoints polylinePoints =PolylinePoints();

// // //     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
// // //       google_api_key, 
// // //       PointLatLng(sourceLocation.latitude, sourceLocation.longitude), 
// // //       PointLatLng(destinationLocation.latitude, destinationLocation.longitude)
// // //     );


// // //     if(result.points.isNotEmpty){
// // //       result.points.forEach(
// // //         (PointLatLng point)=> polylineCoordinates.add (
// // //           LatLng(point.latitude , point.longitude), 
// // //         ),
// // //       );
// // //       setState(() {

// // //       });
// // //     }
// // //   }

// // //   // LatLng?  currentP=null;

// // //   @override
// // //   void initState(){
// // //     getPolyPoints();
// // //     super.initState();    
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text(
// // //           "Track Order",
// // //           style: TextStyle(color: Colors.black ,fontSize: 16),
// // //         ),
// // //       ),
// // //       body: GoogleMap(
// // //         initialCameraPosition: const CameraPosition(
// // //           target: sourceLocation,
// // //           zoom: 14.5 ,
// // //         ),
// // //         polylines: {
// // //           Polyline(
// // //             polylineId: PolylineId("route"),
// // //             points: polylineCoordinates),
// // //             color: Colors.blue,
// // //         },
// // //         markers: {
// // //           const Marker(
// // //             markerId: MarkerId("source"),
// // //             // icon: BitmapDescriptor.defaultMarker ,
// // //             position: sourceLocation
// // //           ),

// // //           // const Marker(
// // //           //   markerId: MarkerId("destination"),
// // //           //   // icon: BitmapDescriptor.defaultMarker ,
// // //           //   position: pGooglePlex
// // //           // ),


// // //           // const Marker(
// // //           //   markerId: MarkerId("destination"),
// // //           //   // icon: BitmapDescriptor.defaultMarker ,
// // //           //   position: pApplePark,  
// // //           // ),
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   Future<void> getLoactionUpdates() async{
// // //     bool serviceEnabled;
// // //     PermissionStatus permissionGranted;

// // //     serviceEnabled = await locationController.serviceEnabled();

// // //     if(serviceEnabled)
// // //     {
// // //       serviceEnabled = await locationController.requestService();
// // //     }else{
// // //       return;
// // //     }

// // //       permissionGranted = await locationController.hasPermission();
// // //       if(permissionGranted == PermissionStatus.denied)
// // //       {
// // //         permissionGranted=await locationController.requestPermission();
// // //         if(permissionGranted != PermissionStatus.granted)
// // //         {
// // //           return;
// // //         }
// // //       }
      
// // //       locationController.onLocationChanged.listen((LocationData currentLocation) {
// // //         if(currentLocation.latitude != null && currentLocation.longitude !=null){
// // //           setState(() {
// // //             currentP = LatLng(currentLocation.latitude!, currentLocation.longitude!);
// // //           });
// // //           print(currentP);
// // //         }
// // //       });
// // //   }

// // // }



// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:location/location.dart';
// // import 'package:shop/common/widgets/loader.dart';
// // import 'package:shop/constants/global_variables.dart';

// // class MapPage extends StatefulWidget {
// //   const MapPage({Key? key}) : super(key: key);

// //   @override
// //   State<MapPage> createState() => MapPageState();
// // }

// // class MapPageState extends State<MapPage> {
// //   final Completer<GoogleMapController> _controller = Completer();
// //   Location locationController = Location();
// //   static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
// //   static const LatLng destinationLocation = LatLng(37.33429383, -122.06600055);
// //   List<LatLng> polylineCoordinates = [];
// //   LocationData? currentLocation;

// //   late BitmapDescriptor sourceIcon;
// //   late BitmapDescriptor destinationIcon;
// //   late BitmapDescriptor currentLocationIcon;

// //   Future<void> setCustomMarkerIcon() async {
// //   // Use built-in icons for source, destination, and current location
// //   sourceIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
// //   destinationIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
// //   currentLocationIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
// // }

// //   Future<void> getPolyPoints() async {
// //   PolylinePoints polylinePoints = PolylinePoints();
// //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
// //     google_api_key,
// //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
// //     PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
// //   );

// //   if (result.points.isNotEmpty) {
// //     result.points.forEach(
// //       (PointLatLng point) =>
// //       polylineCoordinates.add(LatLng(point.latitude, point.longitude)),
// //     );
// //     setState(() {});
// //   } else {
// //     print("No polyline points found!");
// //   }
// // }

// //   void getCurrentLocation() async{
// //     Location location =Location();
// //     location.getLocation().then((location){
// //       setState(() {
// //         currentLocation = location;
// //       });
// //     });
    
// //     GoogleMapController googleMapController = await _controller.future;
// //     location.onLocationChanged.listen((newLoc) { 
// //       setState(() {
// //         currentLocation = newLoc;
// //         googleMapController.animateCamera(
// //           CameraUpdate.newCameraPosition(
// //             CameraPosition(
// //               zoom: 13.5,
// //               target: LatLng(
// //                 newLoc.latitude ?? 0, 
// //                 newLoc.longitude ?? 0,
// //               ),
// //             ),
// //           ),
// //         );
// //       });
// //     });
// //   }

// //   @override
// //   void initState() {
// //     super.initState();
// //     getCurrentLocation();
// //     setCustomMarkerIcon();
// //     getPolyPoints();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     LatLng initialCameraTarget = currentLocation != null
// //         ? LatLng(currentLocation!.latitude ?? 0, currentLocation!.longitude ?? 0)
// //         : sourceLocation;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text(
// //           "Track Order",
// //           style: TextStyle(color: Colors.black, fontSize: 16),
// //         ),
// //       ),
// //       body: currentLocation == null ? const Loader():
// //       GoogleMap(
// //         initialCameraPosition: CameraPosition(
// //           target: LatLng(currentLocation!.latitude ?? 0, currentLocation!.longitude ?? 0),
// //           zoom: 14.5,
// //         ),
// //         polylines: {
// //           Polyline(
// //             polylineId: const PolylineId("route"),
// //             color: Colors.blue,
// //             points: polylineCoordinates,
// //             width: 6,
// //           ),
// //         },
// //         markers: {
// //           if (currentLocation != null)
// //             Marker(
// //               markerId: const MarkerId("currentLocation"),
// //               icon: currentLocationIcon,
// //               position: LatLng(currentLocation!.latitude ?? 0, currentLocation!.longitude ?? 0),
// //             ),
// //           Marker(
// //             markerId: const MarkerId("source"),
// //             icon: sourceIcon,
// //             position: sourceLocation,
// //           ),
// //           Marker(
// //             markerId: const MarkerId("destination"),
// //             icon: destinationIcon,
// //             position: destinationLocation,
// //           ),
// //         },
// //         onMapCreated: (mapController){
// //           _controller.complete(mapController);
// //         } ,
// //       ),
// //     );
// //   }
// // }

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:location/location.dart';
// import 'package:shop/constants/global_variables.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {
//   Location _locationController = new Location();

//   final Completer<GoogleMapController> _mapController =
//       Completer<GoogleMapController>();

//   static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
//   static const LatLng _pApplePark = LatLng(37.3346, -122.0090);
//   LatLng? _currentP = null;

//   Map<PolylineId, Polyline> polylines = {};

//   @override
//   void initState() {
//     super.initState();
//     getLocationUpdates().then(
//       (_) => {
//         getPolylinePoints().then((coordinates) => {
//               generatePolyLineFromPoints(coordinates),
//             }),
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _currentP == null
//           ? const Center(
//               child: Text("Loading..."),
//             )
//           : GoogleMap(
//               onMapCreated: ((GoogleMapController controller) =>
//                   _mapController.complete(controller)),
//               initialCameraPosition: CameraPosition(
//                 target: _pGooglePlex,
//                 zoom: 13,
//               ),
//               markers: {
//                 Marker(
//                   markerId: MarkerId("_currentLocation"),
//                   icon: BitmapDescriptor.defaultMarker,
//                   position: _currentP!,
//                 ),
//                 Marker(
//                     markerId: MarkerId("_sourceLocation"),
//                     icon: BitmapDescriptor.defaultMarker,
//                     position: _pGooglePlex),
//                 Marker(
//                     markerId: MarkerId("_destionationLocation"),
//                     icon: BitmapDescriptor.defaultMarker,
//                     position: _pApplePark)
//               },
//               polylines: Set<Polyline>.of(polylines.values),
//             ),
//     );
//   }

//   Future<void> _cameraToPosition(LatLng pos) async {
//     final GoogleMapController controller = await _mapController.future;
//     CameraPosition _newCameraPosition = CameraPosition(
//       target: pos,
//       zoom: 13,
//     );
//     await controller.animateCamera(
//       CameraUpdate.newCameraPosition(_newCameraPosition),
//     );
//   }

//   Future<void> getLocationUpdates() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await _locationController.serviceEnabled();
//     if (_serviceEnabled) {
//       _serviceEnabled = await _locationController.requestService();
//     } else {
//       return;
//     }

//     _permissionGranted = await _locationController.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await _locationController.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _locationController.onLocationChanged
//         .listen((LocationData currentLocation) {
//       if (currentLocation.latitude != null &&
//           currentLocation.longitude != null) {
//         setState(() {
//           _currentP =
//               LatLng(currentLocation.latitude!, currentLocation.longitude!);
//           _cameraToPosition(_currentP!);
//         });
//       }
//     });
//   }

//   Future<List<LatLng>> getPolylinePoints() async {
//     List<LatLng> polylineCoordinates = [];
//     PolylinePoints polylinePoints = PolylinePoints();
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//       google_api_key,
//       PointLatLng(_pGooglePlex.latitude, _pGooglePlex.longitude),
//       PointLatLng(_pApplePark.latitude, _pApplePark.longitude),
//       travelMode: TravelMode.driving,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     return polylineCoordinates;
//   }

//   void generatePolyLineFromPoints(List<LatLng> polylineCoordinates) async {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//         polylineId: id,
//         color: Colors.black,
//         points: polylineCoordinates,
//         width: 8);
//     setState(() {
//       polylines[id] = polyline;
//     });
//   }
// }

