import 'package:flutter/material.dart';

class Task1Screen extends StatefulWidget {
  const Task1Screen({super.key});

  @override
  _Task1ScreenState createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  List<Map<String, dynamic>> desserts = [
    {"name": "Frozen Yogurt", "calories": 159, "selected": false},
    {"name": "Ice Cream Sandwich", "calories": 237, "selected": false},
    {"name": "Eclair", "calories": 262, "selected": false},
    {"name": "Cupcake", "calories": 305, "selected": false},
    {"name": "Gingerbread", "calories": 356, "selected": false},
    {"name": "Jelly Bean", "calories": 375, "selected": false},
    {"name": "Lollipop", "calories": 392, "selected": false},
    {"name": "Honeycomb", "calories": 408, "selected": false},
    {"name": "Donut", "calories": 452, "selected": false},
  ];

  void _printSelected() {
    List<String> selectedItems =
        desserts
            .where((item) => item['selected'])
            .map<String>((item) => item['name'] as String)
            .toList();

    print("Selected Items: ${selectedItems.join(', ')}");
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Nutrition",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Dessert (100g serving)')),
                DataColumn(label: Text('Calories')),
              ],
              rows:
                  desserts.map((item) {
                    return DataRow(
                      selected: item['selected'],
                      onSelectChanged: (selected) {
                        setState(() {
                          item['selected'] = selected!;
                        });
                        _printSelected();
                      },
                      cells: [
                        DataCell(Text(item['name'])),
                        DataCell(Text(item['calories'].toString())),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
