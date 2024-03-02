import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_utils.dart';
import '../model/task.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  List<Task> taskList = [];
  DateTime selectedDate = DateTime.now();

  void changeLanguage(String newLanguage) {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    saveLanguage();
    notifyListeners();
  }

  void changeTheme(ThemeMode newMode) {
    if (appTheme == newMode) {
      return;
    }
    appTheme = newMode;
    saveTheme();
    notifyListeners();
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }

  saveLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', appLanguage);
    prefs.reload();
    notifyListeners();
  }

  loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString('language') ?? 'en';
    notifyListeners();
  }

  saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('theme', appTheme.index);
    prefs.reload();
    notifyListeners();
  }

  loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? themeIndex = prefs.getInt('theme');
    if (themeIndex != null) {
      appTheme = ThemeMode.values[themeIndex];
    }
    notifyListeners();
  }

  void getAllTasksFromFireStore(String uId) async {
    QuerySnapshot<Task> querySnapshot =
        await FirebaseUtils.getTasksCollection(uId).get();
    taskList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    taskList = taskList.where((task) {
      if (selectedDate.day == task.dateTime!.day &&
          selectedDate.month == task.dateTime!.month &&
          selectedDate.year == task.dateTime!.year) {
        return true;
      }
      return false;
    }).toList();

    taskList.sort((task1, task2) {
      return task1.dateTime!.compareTo(task2.dateTime!);
    });

    notifyListeners();
  }

  void changeSelectedDate(DateTime newSelcetedDate, String uId) {
    selectedDate = newSelcetedDate;
    getAllTasksFromFireStore(uId);
  }
}
