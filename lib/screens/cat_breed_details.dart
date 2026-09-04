import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pragma/providers/cat_breed_provider.dart';

class CatBreedDetailsScreen extends StatelessWidget {
  const CatBreedDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, CatBreedProvider provider, __) {
        return Scaffold(
          appBar: AppBar(
            title: Text(provider.selected?.name ?? ''),
          ),
          body: Column(
            mainAxisAlignment: .center,
            children: [
              Image.network(provider.selected?.image ?? '',
                width: double.infinity,
                height: 500,
                fit: BoxFit.cover,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                    children: [
                      Text(provider.selected?.history ?? '',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text('País de origen: ${provider.selected?.origin ?? ''}',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text('Tiempo de vida: ${provider.selected?.lifeSpan ?? ''}',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      SizedBox(height: 10.0,),
                      Text('Temperamento: ${provider.selected?.temperament ?? ''}',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}