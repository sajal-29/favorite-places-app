import 'package:favorite_places/Screens/map.dart';
import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlacesDetailScreen extends StatelessWidget{
  const PlacesDetailScreen({super.key, required this.place});
  final Place place;

  String get locationImage{
    final lat = place.location.latitutde;
    final lng = place.location.longitutde;
    return 'https://maps.googleapis.com/maps/api/staticmap?center$lat,$lng=&zoom=13&size=600x300&maptype=roadmap &markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyDLIWEuMB6o6ZWMHAuLmzYsl84PWzoxfZ4';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children:  [
          Image.file(place.image,fit: BoxFit.cover,height: double.infinity, width: double.infinity,),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                    radius: 70,
                      backgroundImage: NetworkImage(locationImage),
              ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => MapScreen(
                        location: place.location,
                        isSelecting: false,))
                      );
                    }
                      ),
                      Container(
                      decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Colors.black54,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      )
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                      child: Text(
                      textAlign: TextAlign.center,
                      place.location.address,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                    ),
                  )
                  )],

          ))
        ],

    ));
  }
}