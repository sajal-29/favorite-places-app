import 'dart:convert';

import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget{
  const LocationInput({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInput> createState(){
    return _LocationInput();
  }
}
class _LocationInput extends State<LocationInput>{
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  String get locationImage{
    if(_pickedLocation == null){
      return '';
    }
    final lat = _pickedLocation!.latitutde;
    final lng = _pickedLocation!.longitutde;
    return 'https://maps.googleapis.com/maps/api/staticmap?center$lat,$lng=&zoom=13&size=600x300&maptype=roadmap &markers=color:blue%7Clabel:S%7C$lat,$lng&key=AIzaSyDLIWEuMB6o6ZWMHAuLmzYsl84PWzoxfZ4';
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    locationData = await location.getLocation();
    final lat = locationData.latitude;
    final lng = locationData.longitude;

    if(lat == null || lng == null){
      return;
    }
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyDLIWEuMB6o6ZWMHAuLmzYsl84PWzoxfZ4');
    final response = await http.get(url);
    final responseData = jsonDecode(response.body);
    final address = responseData['results'][0]['formatted_address'];

    setState(() {
      _pickedLocation = PlaceLocation(latitutde: lat, longitutde: lng, address: address);
      _isGettingLocation = false;

      widget.onSelectLocation(_pickedLocation!);
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget previewContent =  Text('No Location chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground
      ),);

    if(_pickedLocation != null){
      previewContent = Image.network(locationImage, fit: BoxFit.cover,width:  double.infinity, height: double.infinity,);
    }
    if(_isGettingLocation){
      previewContent = const Center(child: CircularProgressIndicator());
    }
    return Column(children: [
      Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          ),
        ),
        child: previewContent
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
              onPressed: _getCurrentLocation ,
              icon: const Icon(Icons.location_on),
              label: const Text('Get current Location')),
          TextButton.icon(
              onPressed: (){} ,
              icon: const Icon(Icons.map),
              label: const Text('Select on Map'))
        ],
      )
    ],);

  }
}