import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/space.dart';

class FavoriteController with ChangeNotifier {
  static const String _key = 'fav_amiibo_data';
  List<Space> _favorites = [];

  List<Space> get favorites => _favorites;

  FavoriteController() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonStringList = prefs.getStringList(_key);

    if (jsonStringList != null) {
      _favorites = jsonStringList
          .map((item) => Space.fromJsonDetail(jsonDecode(item)))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonStringList = _favorites
        .map((item) => jsonEncode(item.toString()))
        .toList();
    await prefs.setStringList(_key, jsonStringList);
  }

  bool isFavorite(Space item) {
    return _favorites.any((element) => 
        element. == item.head && element.tail == item.tail);
  }

  Future<void> toggleFavorite(Amiibo item) async {
    if (isFavorite(item)) {
      _favorites.removeWhere((element) => 
          element.head == item.head && element.tail == item.tail);
    } else {
      _favorites.add(item);
    }
    await _saveFavorites();
    notifyListeners();
  }
  
  Future<void> removeFavorite(Amiibo item) async {
    _favorites.removeWhere((element) => 
        element.head == item.head && element.tail == item.tail);
    await _saveFavorites();
    notifyListeners();
  }
}