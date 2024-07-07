import 'dart:convert';

import 'package:math_helper/core/storage/operation.dart';
import 'package:math_helper/core/storage/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences sharedPreferences;

  const LocalStorageService({required this.sharedPreferences});

  Future<bool> setIsDarkMode(bool isDarkMode) async {
    return await sharedPreferences.setBool(Preferences.isDarkMode, isDarkMode);
  }

  bool getIsDarkMode() {
    return sharedPreferences.getBool(Preferences.isDarkMode) ?? false;
  }

  List<Operation> getOperations() {
    final List<String> savedOperations =
        sharedPreferences.getStringList(Preferences.operations) ?? [];
    return savedOperations
        .map((operation) => Operation.fromJson(jsonDecode(operation)))
        .toList();
  }

  Future<bool> registerOperation(Operation operation) {
    final List<String> savedOperations =
        sharedPreferences.getStringList(Preferences.operations) ?? [];
    savedOperations.add(jsonEncode(operation.toJson()));
    return sharedPreferences.setStringList(
        Preferences.operations, savedOperations);
  }
}
