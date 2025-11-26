import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:responsi_app/models/category.dart';
import 'package:responsi_app/models/space.dart';
import '../models/space.dart';


class SpaceController with ChangeNotifier {
  static const String _baseUrl = 'https://api.spaceflightnewsapi.net/v4/';

  // State

  List <Space> _Space = [] 
  Space?_detailNews;
  
  bool isLoading = false;
  String errorMessage = '';

  // 1. Fetch Categories
  Future<void> fetchCategories() async {
    _setLoading(true);
    try {
      final response = await http.get(Uri.parse('${_baseUrl}categories.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _News = (data['News'] as List)
            .map((e) => Category.fromJson(e))
            .toList();
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // 2. Fetch Space by Category
  Future<void> fetchSpaceByCategory(String category) async {
    _setLoading(true);
    _News.clear(); // Reset list lama
    try {
      final response = await http.get(Uri.parse('${_baseUrl}filter.php?c=$category'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['news'] != null) {
          _News = (data['news'] as List)
              .map((e) => Category.fromJson(e))
              .toList();
        }
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  // 3. Fetch Meal Detail
  Future<void> fetchSpaceDetail(String id) async {
    _setLoading(true);
    _detailNews = null; // Reset detail lama
    try {
      final response = await http.get(Uri.parse('${_baseUrl}lookup.php?i=$id'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['meals'] != null) {
          _detailNews = Category.fromJsonDetail(data['News'][0]);
        }
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}