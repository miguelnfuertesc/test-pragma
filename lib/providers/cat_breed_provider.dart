import 'package:flutter/material.dart';
import 'package:test_pragma/models/cat_breed.dart';
import 'package:test_pragma/data/webclient.dart';

class CatBreedProvider with ChangeNotifier { 
  List<CatBreed> catBreeds;
  List<CatBreed> cachedCatBreeds;
  CatBreed? selected;
  bool isLoading = false;
  String? _errorMessage;

  CatBreedProvider({
    required this.catBreeds,
    required this.cachedCatBreeds,
  });

  void onSelected(CatBreed cat) {
    selected = cat;
    notifyListeners();
  }

  void onSearch(String search) {
    if (search == '') {
      catBreeds..clear()..addAll(cachedCatBreeds);
      notifyListeners();
      return;
    }

    List<CatBreed> list = cachedCatBreeds.where(
      (element) => element.name?.toLowerCase().contains(search.toLowerCase()) ?? false
    ).toList();
    catBreeds..clear()..addAll(list);
    notifyListeners();
  }

  Future<void> fetchCatBreeds() async {
    isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final webClient = WebClient.userApi(null);
      final path = '/breeds';
      final response = await webClient.get(path);

      catBreeds = response.map((json) => CatBreed.fromJson(json)).toList();
      cachedCatBreeds = List.of(catBreeds).toList();
    } catch (e) {
      _errorMessage = 'Error en la red: $e';
      debugPrint('__DEBUG_ERROR__${e}');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}