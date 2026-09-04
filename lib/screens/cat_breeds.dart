import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_pragma/providers/cat_breed_provider.dart';
import 'package:test_pragma/models/cat_breed.dart';
import 'package:test_pragma/screens/cat_breed_details.dart';

class CatBreedsScreen extends StatefulWidget {
  const CatBreedsScreen({
    super.key,
  });

  @override
  State<CatBreedsScreen> createState() => _CatBreedsScreenState();
}

class _CatBreedsScreenState extends State<CatBreedsScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CatBreedProvider>().fetchCatBreeds();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Consumer(builder: (_, CatBreedProvider provider, __) {
          if (provider.isLoading) {
            return Center(
              child: Text('Cargando...'),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('CatBreeds'),
                AppSearch(),
                AppCardList(),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class AppSearch extends StatelessWidget {
  const AppSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, CatBreedProvider provider, __) {
        return Padding(
          padding: const EdgeInsets.all(7.0),
          child: SearchBar(
            hintText: 'Buscar raza...',
            leading: const Icon(Icons.search),
            onChanged: (selected) => provider.onSearch(selected),
          ),
        );
      },
    );
  }
}

class AppCardList extends StatelessWidget {
  const AppCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, CatBreedProvider provider, __) {
        return Flexible(
          child: ListView(
            children: provider.catBreeds.map((CatBreed currentCat)
            => InkWell(
              onTap: () {
                provider.onSelected(currentCat);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CatBreedDetailsScreen()),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(currentCat.name ?? ''),
                          Text('Más...'),
                        ],
                      ),
                      currentCat.image == null || currentCat.image == '' ? 
                      Text('Imagen no disponible') :
                      Image.network(currentCat.image ?? '',
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      Text(currentCat.origin ?? ''),
                      Text(currentCat.temperament ?? ''),
                    ],
                  ),
                ),
              ),
            ),
            ).toList(),
          )
        );
      },
    );
  }
}