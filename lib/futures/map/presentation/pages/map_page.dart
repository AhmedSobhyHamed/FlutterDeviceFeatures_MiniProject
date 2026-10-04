import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutterdevicefeatures_miniproject/futures/map/domain/current_position.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _mapController = Completer<GoogleMapController>();
  CameraPosition _cameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 10,
  );

  @override
  void initState() {
    super.initState();
    _addMarkerAtCairoLocation();
    _goToMarker(const LatLng(30.0626, 31.2497));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Map Page'),
      ),
      body: Center(
        child: GoogleMap(
          mapType: MapType.normal,
          markers: _markers,
          initialCameraPosition: _cameraPosition,
          onMapCreated: (controller) {
            _mapController.complete(controller);
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 10,
        children: [
          FloatingActionButton(
            onPressed: _getCurrentLatLng,
            tooltip: 'Get Current Location',
            child: Icon(Icons.location_on),
          ),
          FloatingActionButton(
            onPressed: _goToCurrentLocation,
            tooltip: 'go to current location',
            child: Icon(Icons.location_on_outlined),
          ),
          FloatingActionButton(
            onPressed: _clearMarkers,
            tooltip: 'clear markers',
            child: Icon(Icons.clear),
          ),
          FloatingActionButton(
            onPressed: _addMarker,
            tooltip: 'add marker at current location',
            child: Icon(Icons.add_location),
          ),
        ],
      ), 
      
    );
  }

  static Future<Marker> mapMarker(LatLng latLng, {String? icon}) async {
    final BitmapDescriptor bitmap = icon == null
      ? BitmapDescriptor.defaultMarker
      : await BitmapDescriptor.asset(
          const ImageConfiguration(size: Size(100, 100)),
          icon,
          width: 30,
          height: 30,
        );
    return Marker(
      markerId: MarkerId(latLng.toString()),
      position: latLng,
      icon: bitmap,
    );
  }

  Future<void> _getCurrentLatLng() async {
    final latLng = await CurrentPosition.getCurrentLatLng();
    if (latLng == null) return;
    final marker = await mapMarker(latLng);
    setState(() {
      _markers.clear();
      _markers.add(marker);
    });
  }

  Future<void> _goToCurrentLocation() async {
    final controller = await _mapController.future;
    final latLng = await CurrentPosition.getCurrentLatLng();
    if (latLng != null) {
      controller.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
      _cameraPosition = CameraPosition(
        target: latLng,
        zoom: 16,
      );
    }
  }

  Future<void> _goToMarker(LatLng latLng) async {
    final controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(latLng, 16));
    _cameraPosition = CameraPosition(
      target: latLng,
      zoom: 4,
    );
  }

  Future<void> _clearMarkers() async {
    setState(() {
      _markers.clear();
    });
  }

  Future<void> _addMarker() async {
    final controller = await _mapController.future;
    final bounds = await controller.getVisibleRegion();
    final center = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );
    final marker = await mapMarker(center, icon: 'assets/images/images.jpg');
    setState(() { 
      _markers.add(marker);
    });
  }

  Future<void> _addMarkerAtCairoLocation() async {
    final controller = await _mapController.future;
    final marker = await mapMarker(LatLng(30.0626, 31.2497));
    setState(() {
      _markers.add(marker);
    });
  }
}