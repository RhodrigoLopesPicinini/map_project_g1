import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SimpleMapScreen extends StatefulWidget {
  const SimpleMapScreen({Key? key}) : super(key: key);

  @override
  _SimpleMapScreenState createState() => _SimpleMapScreenState();
}

class _SimpleMapScreenState extends State<SimpleMapScreen> {

  final Set<Polyline> _polylines = Set();

  LatLng atitus = const LatLng(-28.26511069131996, -52.39715499243398);
  LatLng shopping = const LatLng(-28.2713760952866, -52.38582460204754);

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition initialPosition = CameraPosition(
      target: LatLng(-28.262255099629396, -52.41080331002769), zoom: 14.0);

  static const CameraPosition atitusPosition = CameraPosition(
      target: LatLng(-28.26511069131996, -52.39715499243398),
      zoom: 20.0,
      bearing: 192.0,
      tilt: 60);


  static const CameraPosition shoppingPosition = CameraPosition(
      target: LatLng(-28.2713760952866, -52.38582460204754),
      zoom: 20.0,
      bearing: 192.0,
      tilt: 60);

  @override
  Widget build(BuildContext context) {


    _polylines.add(
        Polyline(
            polylineId: const PolylineId("line 1"),
            visible: true,
            width: 2,
            //latlng is List<LatLng>
            patterns: [PatternItem.dash(30), PatternItem.gap(10)],
            points: [atitus, shopping], // Invoke lib to get curved line points
            color: Colors.blue,
        )
    );


    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Google Map"),
        centerTitle: true,
      ),
      body: GoogleMap( 
        markers: {
          const Marker(
            markerId: MarkerId("marker1"),
            position: LatLng(-28.26511069131996, -52.39715499243398),
          ),
          const Marker(
            markerId: MarkerId("marker2"),
            position: LatLng(-28.2713760952866, -52.38582460204754),
          ),
        },
        polylines: _polylines,
        initialCameraPosition: initialPosition,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },

      ),

            

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  
      floatingActionButton: Row(children: [
        
          const SizedBox(
            width: 50,
          ),

        FloatingActionButton.extended(
          onPressed: () {
            goToAtitus();
          },
          label: const Text("Vá para Atitus!"),
          icon: const Icon(Icons.adobe_outlined),
        ),

        const SizedBox(
          width: 50,
        ),

        FloatingActionButton.extended(
          onPressed: () {
            goToShopping();
          },
          label: const Text("Vá para o Shopping!"),
          icon: const Icon(Icons.adobe_outlined),
        ),
      ],
      ) 


    );
    
  }

  Future<void> goToAtitus() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(atitusPosition));
  }  
  Future<void> goToShopping() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(shoppingPosition));
  }
}
