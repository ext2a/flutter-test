import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDark = false.obs;

  void changeTheme(state) {
    isDark(state);
    Get.changeTheme(!state ? ThemeData.light() : ThemeData.dark());
  }
}
