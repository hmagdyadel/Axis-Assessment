import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/people/data/models/people_model.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  static const String _peopleBoxName = 'people_cache';
  Box<String>? _peopleBox;

  // Get the singleton instance
  static HiveService get instance => _instance;

  // Initialize Hive and open the people cache box
  Future<void> initialize() async {
    await Hive.initFlutter();
    _peopleBox = await Hive.openBox<String>(_peopleBoxName);
  }

  // Save PeopleModel data for a specific page
  Future<void> savePeopleData(int pageNumber, PeopleModel peopleModel) async {
    final key = _generatePeopleKey(pageNumber);
    final jsonString = jsonEncode(peopleModel.toJson());
    await _peopleBox!.put(key, jsonString);
  }

  // Retrieve PeopleModel data for a specific page
  PeopleModel? getPeopleData(int pageNumber) {
    final key = _generatePeopleKey(pageNumber);
    final jsonString = _peopleBox!.get(key);

    if (jsonString == null) {
      return null;
    }

    try {
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return PeopleModel.fromJson(jsonMap);
    } catch (e) {
      _peopleBox!.delete(key);
      return null;
    }
  }

  // Generate cache key for people data
  String _generatePeopleKey(int pageNumber) {
    return 'people_page_$pageNumber';
  }
}