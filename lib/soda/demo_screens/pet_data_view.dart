import 'package:flutter/material.dart';
import 'package:second_challenge/soda/demo_screens/pet_preferences.dart';

class PetDataView extends StatelessWidget {
  const PetDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = PetPreferences.myPet;
    return Scaffold(backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          PetCard(
            petPrice: '',
            petAge: '',
            petImagePath: 'assets/images/dog_breeds/beagle.jpg',
            petBreedName: '',),
          PetCard(
            petPrice: '',
            petAge: '',
            petImagePath: 'assets/images/cat_breeds/maine-coon.jpg',
            petBreedName: '',),
        ],
      ),
    );
  }
}

class PetCard extends StatelessWidget {
  const PetCard({Key? key,
    required this.petImagePath,
    required this.petBreedName,
    required this.petAge,
    required this.petPrice}) : super(key: key);
  final String petImagePath;
  final String petBreedName;
  final String petAge;
  final String petPrice;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildImage(),

    );
  }

  Widget buildImage() {
    final image = NetworkImage(petImagePath);
    return Ink.image(
        image: image,
      fit: BoxFit.cover,
        width: 250,
        height: 250,
    );
  }
}


