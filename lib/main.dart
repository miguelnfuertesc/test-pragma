import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pragma/screens/cat_breeds.dart';
import 'package:test_pragma/providers/cat_breed_provider.dart';
import 'package:test_pragma/models/cat_breed.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CatBreedProvider(
          catBreeds: <CatBreed>[],
          cachedCatBreeds: <CatBreed>[],
        )),
      ],
      child: MaterialApp(
        title: 'A cat app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: CatBreedsScreen(),
      ),
    );
  }
}