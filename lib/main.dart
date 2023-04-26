import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:refactor_task/controllers/theme_controller.dart';
import 'package:refactor_task/models/item.dart';
import './widgets/home.dart';
import './controllers/item_controller.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ItemAdapter());
  box = await Hive.openBox<Item>("items");
  Get.put(ItemController());
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Refactor Task App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}
