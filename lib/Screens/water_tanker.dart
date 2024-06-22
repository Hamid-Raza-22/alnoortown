import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WaterTanker extends StatefulWidget {
  const WaterTanker({super.key});

  @override
  _WaterTankerState createState() => _WaterTankerState();
}

class _WaterTankerState extends State<WaterTanker> {
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  final List<String> streets = ["Street 1", "Street 2", "Street 3", "Street 4", "Street 5", "Street 6", "Street 7"];
  List<Map<String, dynamic>> containerDataList = [];

  @override
  void initState() {
    super.initState();
    containerDataList.add(createInitialContainerData());
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedBlock": null,
      "selectedStreet": null,
      "selectedTankers": null,
    };
  }

  String getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Text(
                getCurrentDate(),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ...containerDataList.asMap().entries.map((entry) {
              int index = entry.key;
              return buildContainer(index);
            }),
            const SizedBox(height: 16),
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    containerDataList.add(createInitialContainerData());
                  });
                },
                backgroundColor: const Color(0xFFC69840),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(int index) {
    var containerData = containerDataList[index];
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockStreetRow(containerData),
            const SizedBox(height: 16),
            const Text(
              "No. of Tankers",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: containerData["selectedTankers"],
              items: List.generate(10, (index) => index + 1).map((number) {
                return DropdownMenuItem(
                  value: number,
                  child: Text(number.toString()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  containerData["selectedTankers"] = value;
                });
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC69840)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final selectedMachine = containerData["selectedMachine"];
                  final selectedBlock = containerData["selectedBlock"];
                  final selectedStreet = containerData["selectedStreet"];
                  final selectedTankers = containerData["selectedTankers"];

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: $selectedMachine, $selectedBlock, $selectedStreet, No. of Tankers: $selectedTankers',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F4F6),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 14),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: const Text('Submit', style: TextStyle(color: Color(0xFFC69840))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBlockStreetRow(Map<String, dynamic> containerData) {
    return Row(
      children: [
        Expanded(
          child: buildDropdownField(
              "Block No.", containerData, "selectedBlock", blocks
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: buildDropdownField(
              "Street No.", containerData, "selectedStreet", streets
          ),
        ),
      ],
    );
  }

  Widget buildDropdownField(String title, Map<String, dynamic> containerData, String key, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: containerData[key],
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              containerData[key] = value;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC69840)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ],
    );
  }
}
