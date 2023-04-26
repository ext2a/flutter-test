import 'package:get/get.dart';
import 'package:refactor_task/hive/data.dart';
import 'package:refactor_task/models/item.dart';

class ItemController extends GetxController {
  var items = <Item>[].obs;
  var isLoading = false.obs;
  var isGrid = false.obs;

  ItemController() {
    editItems(online: false);
  }

  editItems({online = true}) async {
    isLoading(true);
    List<Item> s = await fetchItems(online) ?? [];
    items.value = s;
    isLoading(false);
  }
}
