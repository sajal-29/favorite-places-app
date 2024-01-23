import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapScreen extends StatefulWidget{
  const MapScreen({
    super.key,
    this.location = const PlaceLocation(
        latitutde: 37.433,
        longitutde: -122.084,
        address: ''
    ),
    this.isSelecting = true,
  });

  final PlaceLocation location;
  final bool isSelecting;

  State<MapScreen> createState(){
    return _MapScreen();
  }
}
class _MapScreen extends State<MapScreen>{
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isSelecting ? 'Pick Your Location': 'Your Location'),
        actions: [
          if(widget.isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: (){},
            )
        ],
      ),
      body: GoogleMap(
        onTap: (position){
          setState(() {
            _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(target:
        LatLng(
            widget.location.latitutde,
            widget.location.longitutde
        ),
        zoom: 15,
        ),
        markers: (_pickedLocation == null && widget.isSelecting)? {} : {
          Marker(
              markerId: const MarkerId('m1'),
            position: _pickedLocation != null ? _pickedLocation!
            // we can also use _pickedLocation ?? instead of != null
                : LatLng(
                widget.location.latitutde,
                widget.location.longitutde
            ),
          )
        },
      ),
    );
  }
}