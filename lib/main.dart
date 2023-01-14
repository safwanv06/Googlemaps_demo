import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Location lctn = Location();
  CameraPosition init = const CameraPosition(target: LatLng(11.258753, 75.780411), zoom: 15);

  cls() async {

    LocationData lctndata = await lctn.getLocation();
    print(lctndata.longitude);
      init = CameraPosition(
          target: LatLng(lctndata.latitude!, lctndata.longitude!),zoom: 15);
      print(init);
    mapController!.animateCamera(CameraUpdate.newCameraPosition(init));
  }
GoogleMapController? mapController;
  @override
  Widget build(BuildContext context) {
    print('rebuilt');
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        initialCameraPosition: init,
        onMapCreated: (controller) {
          mapController=controller;
      },),
      floatingActionButton:
          FloatingActionButton(onPressed: cls, child: Icon(Icons.add)),
    );
  }
}
