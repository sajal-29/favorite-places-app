import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/place.dart';
import 'dart:io';

class PlaceNotifier extends StateNotifier <List<Place>>{
  PlaceNotifier() : super([]);

  void addPlace(Place place, File image, PlaceLocation location){
    final newPlace = Place(title: place.title, image: place.image, location: location);
    state = [newPlace,...state];
  }
}
final favoritePlaceProvider = StateNotifierProvider<PlaceNotifier, List<Place>>((ref) => PlaceNotifier());