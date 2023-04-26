import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:refactor_task/controllers/item_controller.dart';
import 'package:refactor_task/controllers/theme_controller.dart';

class MyHomePage extends GetView<ItemController> {
  MyHomePage({super.key});
  final itemController = Get.find<ItemController>();
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Refactor Task App'),
        actions: [
          Obx(
            () => Row(children: [
              const Text("Dark Mode"),
              Switch(
                value: themeController.isDark(),
                onChanged: (value) {
                  themeController.changeTheme(value);
                },
              ),
            ]),
          ),
          Obx(
            () => Row(children: [
              const Text("Grid/List"),
              Switch(
                value: itemController.isGrid(),
                onChanged: (value) {
                  itemController.isGrid(!itemController.isGrid());
                },
              ),
            ]),
          ),
        ],
      ),
      body: Obx(
        () => itemController.isLoading()
            ? const Center(child: CircularProgressIndicator())
            : (itemController.isGrid()
                ? Container(
                    margin: const EdgeInsets.all(10),
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemCount: itemController.items.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(15)),
                            child: SingleChildScrollView(
                                child: Column(children: [
                              Text(
                                itemController.items[index].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(itemController.items[index].body)
                            ])),
                          );
                        }))
                : ListView.builder(
                    itemCount: itemController.items.length,
                    itemBuilder: (context, index) {
                      final item = itemController.items[index];
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.body),
                      );
                    },
                  )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          itemController.editItems();
        },
        tooltip: 'Fetch Data',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
