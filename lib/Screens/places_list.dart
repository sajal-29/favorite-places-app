import 'package:favorite_places/Screens/add_place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/widgets/places.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesListScreen extends ConsumerWidget{
  const PlacesListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPlaces = ref.watch(favoritePlaceProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places', style: Theme.of(context).textTheme.titleLarge,),
        actions: [
          IconButton(onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (ctx) =>  AddPlacesScreen()));}, icon: const Icon(Icons.add))
        ],
      ),
      body: PlacesList(places: userPlaces)
    );
  }
}