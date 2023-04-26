import 'dart:convert';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:refactor_task/models/item.dart';

Future<List<Item>?> fetchItems(bool online) async {
  Box<Item> box = Hive.box('items');
  if (online) {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      final itemList = data.map((item) => Item.fromJson(item)).toList();
      await box.addAll(itemList);
      return itemList;
    } else {
      Get.snackbar("Error ", "Error fetching data from server.");
    }
  }
  List<Item>? items = box.values.toList();
  return items;
}
