import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import '../providers/places_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class AddPlacesScreen extends ConsumerStatefulWidget{
  const AddPlacesScreen({super.key});


  @override
  ConsumerState<AddPlacesScreen> createState() => _AddPlacesScreenState();
}

class _AddPlacesScreenState extends ConsumerState<AddPlacesScreen> {
  File? _selectedImage;
  var _name = "";
  final _formkey = GlobalKey<FormState>();
  PlaceLocation? _selectedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Place',style: Theme.of(context).textTheme.titleLarge),
      ),
      body: Form(
        key: _formkey,
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              decoration: const InputDecoration(label: Text('Title'),),
              onSaved: (value){
                _name = value!;
              },
            ),
          ),

          ImageInput(onPickImage: (image) {
            _selectedImage = image;
          }),

          const SizedBox(height: 16,),

          LocationInput(
            onSelectLocation: (location){
              _selectedLocation = location;
            },
          ),

          const SizedBox(height: 16,),

          ElevatedButton.icon(
            onPressed:(){
              _formkey.currentState!.save();
              ref.read(favoritePlaceProvider.notifier).addPlace(Place(title: _name, image: _selectedImage!, location: _selectedLocation!), _selectedImage!,PlaceLocation(latitutde: _selectedLocation!.latitutde, longitutde: _selectedLocation!.longitutde, address: _selectedLocation!.address));
              Navigator.pop(context);
          } ,
            icon: const Icon(Icons.add),
            label: const Text('Add Place'),
          )
          ],
      )),
    );
  }
}