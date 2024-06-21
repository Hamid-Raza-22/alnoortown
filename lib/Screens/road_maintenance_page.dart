import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class RoadMaintenancePage extends StatefulWidget {
  @override
  _RoadMaintenancePageState createState() => _RoadMaintenancePageState();
}

class _RoadMaintenancePageState extends State<RoadMaintenancePage> {
  final List<String> machines = [
    "Excavator", "Bulldozer", "Crane", "Loader", "Dump Truck", "Forklift", "Paver"
  ];
  final List<Icon> machineIcons = [
    Icon(Icons.construction, color: Color(0xFFC69840)), // Example: Changing color to blue
    Icon(Icons.agriculture, color: Color(0xFFC69840)),
    Icon(Icons.account_balance, color: Color(0xFFC69840)),
    Icon(Icons.local_shipping, color: Color(0xFFC69840)),
    Icon(Icons.fire_truck, color: Color(0xFFC69840)),
    Icon(Icons.precision_manufacturing, color: Color(0xFFC69840)),
    Icon(Icons.add_box, color: Color(0xFFC69840)),
  ];
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
      "selectedMachine": null,
      "selectedBlock": null,
      "selectedStreet": null,
      "clockInTime": "00:00 AM",
      "clockOutTime": "00:00 AM",
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
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            ...containerDataList.asMap().entries.map((entry) {
              int index = entry.key;
              return buildContainer(index);
            }).toList(),
            SizedBox(height: 16),
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    containerDataList.add(createInitialContainerData());
                  });
                },
                child: Icon(Icons.add),
                backgroundColor: Color(0xFFC69840),
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
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockStreetRow(containerData),
            SizedBox(height: 16),
            const Text(
              "Machine",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: containerData["selectedMachine"],
              items: machines.asMap().entries.map((entry) {
                int idx = entry.key;
                String machine = entry.value;
                return DropdownMenuItem(
                  value: machine,
                  child: Row(
                    children: [
                      machineIcons[idx],
                      SizedBox(width: 8),
                      Text(machine),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  containerData["selectedMachine"] = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC69840)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            const SizedBox(height: 20),
            buildTimeButtons(containerData),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final selectedMachine = containerData["selectedMachine"];
                  final selectedBlock = containerData["selectedBlock"];
                  final selectedStreet = containerData["selectedStreet"];
                  final clockInTime = containerData["clockInTime"];
                  final clockOutTime = containerData["clockOutTime"];

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: $selectedMachine, $selectedBlock, $selectedStreet, Time In: $clockInTime, Time Out: $clockOutTime',
                      ),
                    ),
                  );
                },
                child: const Text('Submit', style: TextStyle(color: Color(0xFFC69840))), // Text color golden
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF3F4F6),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${containerData["clockInTime"]}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                  ),
                  Text(
                    '${containerData["clockOutTime"]}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                  ),
                ],
              ),
            )
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
              "Block No." , containerData, "selectedBlock", blocks
          ),
        ),
        SizedBox(width: 16),
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
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC69840)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ],
    );
  }

  Widget buildTimeButtons(Map<String, dynamic> containerData) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              containerData["clockInTime"] = getCurrentTime();
            });
          },
          icon: Icon(Icons.access_time, color: Color(0xFFC69840)),
          label: const Text('Time In', style: TextStyle(color: Color(0xFFC69840))),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF3F4F6),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            textStyle: const TextStyle(fontSize: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              containerData["clockOutTime"] = getCurrentTime();
            });
          },
          icon: Icon(Icons.access_time, color: Color(0xFFC69840)),
          label: const Text('Time Out', style: TextStyle(color: Color(0xFFC69840))),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFF3F4F6),
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            textStyle: const TextStyle(fontSize: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ],
    );
  }

  String getCurrentTime() {
    final now = DateTime.now();
    String period = now.hour >= 12 ? 'PM' : 'AM';
    int hour = now.hour % 12;
    hour = hour == 0 ? 12 : hour;
    return "${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $period";
  }
}
