import 'package:flutter/material.dart';
import 'package:food_hub/utils/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class GoogleMapsScreen extends StatefulWidget {
  @override
  _GoogleMapsScreenState createState() => _GoogleMapsScreenState();
}

class _GoogleMapsScreenState extends State<GoogleMapsScreen> {
  late GoogleMapController mapController;
  LatLng selectedLocation = LatLng(-12.0464, -77.0428); // Lima, Perú por defecto
  String address = "";
  LatLng? currentLocation;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _onMapTapped(LatLng coordinates) async {
    setState(() {
      selectedLocation = coordinates;
      address = "";
    });

    String locationAddress = await _getAddressFromCoordinates(coordinates);
    setState(() {
      address = locationAddress;
    });
  }

  Future<String> _getAddressFromCoordinates(LatLng coordinates) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.street}, ${place.locality}, ${place.country}";
      }
    } catch (e) {
      return "Dirección no encontrada";
    }
    return "Dirección no encontrada";
  }

  // determina la ubicación actual
  Future<void> _determinePosition() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    
    String locationAddress = await _getAddressFromCoordinates(LatLng(position.latitude, position.longitude));
    mapController.animateCamera(CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude)));
    setState(() {
      currentLocation = LatLng(position.latitude, position.longitude);
      selectedLocation = currentLocation!;
      address = locationAddress;
    });

  }

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Selecciona una ubicación', style: TextStyle(color: AppColors.mainColor, fontSize: 22,
            fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: AppColors.mainColor),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, color: Colors.white),
          style: IconButton.styleFrom(backgroundColor: AppColors.mainColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: selectedLocation,
                zoom: 14,
              ),
              onMapCreated: _onMapCreated,
              onTap: _onMapTapped,
              markers: {
                Marker(
                  markerId: MarkerId("selected-location"),
                  position: selectedLocation,
                ),
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, right: 10, left: 10),
            color: Colors.white,
            child: address == "" 
            ? CircularProgressIndicator(color: AppColors.mainColor)
            : Text("Dirección: $address", style: TextStyle(fontSize: 16)),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor),
              onPressed: address == "" ? null : () => {
                Navigator.pop(context, address)
              },
              child: const Text('Guardar', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}