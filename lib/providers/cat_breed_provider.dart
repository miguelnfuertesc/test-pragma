import 'package:flutter/material.dart';
import 'package:test_pragma/models/cat_breed.dart';
import 'package:test_pragma/data/webclient.dart';

class CatBreedProvider with ChangeNotifier { 
  List<CatBreed> catBreeds;
  CatBreed? selected;
  bool isLoading = false;
  String? _errorMessage;

  CatBreedProvider({
    required this.catBreeds,
  });

  void onSelected(CatBreed cat) {
    selected = cat;
    notifyListeners();
  }

  void onSearch(String search) {
    if (search == '') {
      fetchCatBreeds();
    }

    List<CatBreed> list = catBreeds.where(
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
    } catch (e) {
      _errorMessage = 'Error en la red: $e';
      debugPrint('__DEBUG_ERROR__${e}');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

}