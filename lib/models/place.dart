import 'dart:io';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();


class PlaceLocation{
  const PlaceLocation({required this.latitutde,
    required this.longitutde,
    required this.address
  });
  final double latitutde;
  final double longitutde;
  final String address;

}
class Place {
  Place({required this.title, required this.image, required this.location}) : id = uuid.v4();
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;



}