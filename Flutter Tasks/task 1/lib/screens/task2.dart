import 'package:flutter/material.dart';
import '../widgets/storage_service.dart';

class Task2Screen extends StatefulWidget {
  const Task2Screen({super.key});

  @override
  _Task2ScreenState createState() => _Task2ScreenState();
}

class _Task2ScreenState extends State<Task2Screen> {
  String? selectedItem;

  List<Map<String, String>> items = List.generate(
    6,
    (index) => {
      "title": "Item ${index + 1}",
      "image": "https://picsum.photos/200?random=$index",
    },
  );

  @override
  void initState() {
    super.initState();
    _loadSelectedItem();
  }

  void _loadSelectedItem() async {
    String? savedItem = await StorageService.getSelectedItem();
    print("🔹 Stored item: $savedItem");

    setState(() {
      selectedItem = savedItem;
    });
  }

  void _onItemSelected(String title) {
    setState(() {
      selectedItem = title;
    });
    StorageService.saveSelectedItem(title);
    print("✅ Item saved: $title");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GridView with Secure Storage"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              await StorageService.clearStorage();
              setState(() {
                selectedItem = null;
              });
              print("🗑 Storage Cleared");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            bool isSelected = item["title"] == selectedItem;

            return GestureDetector(
              onTap: () => _onItemSelected(item["title"]!),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(item["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: Text(
                      item["title"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
