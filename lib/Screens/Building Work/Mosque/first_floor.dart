import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FirstFloorWork extends StatefulWidget {
  const FirstFloorWork({super.key});

  @override
  _FirstFloorWorkState createState() => _FirstFloorWorkState();
}

class _FirstFloorWorkState extends State<FirstFloorWork> {
  final List<String> blocks = [
    "Block A",
    "Block B",
    "Block C",
    "Block D",
    "Block E",
    "Block F",
    "Block G"
  ];
  List<Map<String, dynamic>> containerDataList = [];

  String? selectedBlock;
  String? selectedBrickWorkStatus;
  String? selectedMudFillingStatus;
  String? selectedPlasterWorkStatus;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('firstFloorWorkData'); // Unique key for First Floor Work
    if (savedData != null) {
      setState(() {
        containerDataList = List<Map<String, dynamic>>.from(json.decode(savedData));
      });
    }
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstFloorWorkData', json.encode(containerDataList)); // Unique key for First Floor Work
  }

  Map<String, dynamic> createNewEntry(String? selectedBlock, String? brickStatus, String? mudStatus, String? plasterStatus) {
    return {
      "selectedBlock": selectedBlock,
      "brickWorkStatus": brickStatus,
      "mudFillingStatus": mudStatus,
      "plasterWorkStatus": plasterStatus,
      "timestamp": DateTime.now().toIso8601String(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_edu_outlined, color: Color(0xFFC69840)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FirstFloorSummaryPage(containerDataList: containerDataList),
                ),
              );
            },
          ),
        ],
        title: const Text(
          'First Floor Work',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/firstfloor.png',
              fit: BoxFit.cover,
              height: 170.0,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildContainer(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockRow((value) {
              setState(() {
                selectedBlock = value;
              });
            }),
            const SizedBox(height: 16),
            buildStatusColumn(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedBlock != null && selectedBrickWorkStatus != null && selectedMudFillingStatus != null && selectedPlasterWorkStatus != null) {
                    Map<String, dynamic> newEntry = createNewEntry(
                        selectedBlock,
                        selectedBrickWorkStatus,
                        selectedMudFillingStatus,
                        selectedPlasterWorkStatus);

                    setState(() {
                      containerDataList.add(newEntry);
                    });

                    await _saveData(); // Save the data with the unique key

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Entry added successfully!'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select all statuses.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F4F6),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Submit',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBlockRow(ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Block No.",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC69840))),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          items: blocks.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC69840))),
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ],
    );
  }

  Widget buildStatusColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStatusRow("Brick Work", selectedBrickWorkStatus, (value) {
          setState(() {
            selectedBrickWorkStatus = value;
          });
        }),
        buildStatusRow("Mud Filling", selectedMudFillingStatus, (value) {
          setState(() {
            selectedMudFillingStatus = value;
          });
        }),
        buildStatusRow("Plaster Work", selectedPlasterWorkStatus, (value) {
          setState(() {
            selectedPlasterWorkStatus = value;
          });
        }),
      ],
    );
  }

  Widget buildStatusRow(String title, String? groupValue, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
        Row(
          children: [
            buildRadioButton("In Process", groupValue, onChanged),
            buildRadioButton("Done", groupValue, onChanged),
          ],
        ),
        const SizedBox(height: 16), // Adds space between rows
      ],
    );
  }

  Widget buildRadioButton(String title, String? groupValue, ValueChanged<String?> onChanged) {
    return Row(
      children: [
        Radio<String>(
          value: title,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: const Color(0xFFC69840),
        ),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

class FirstFloorSummaryPage extends StatelessWidget {
  final List<Map<String, dynamic>> containerDataList;
  const FirstFloorSummaryPage({super.key, required this.containerDataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'First Floor Summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 4),
            // Data Grid
            Expanded(
              child: ListView.builder(
                itemCount: containerDataList.length,
                itemBuilder: (context, index) {
                  final data = containerDataList[index];
                  return _buildDataRow(data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildDataRow(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC69840), width: 1.0),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          children: [
            _buildDataCell("Block No", data["selectedBlock"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell("Brick Work", data["brickWorkStatus"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell("Mud Filling", data["mudFillingStatus"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell("Plaster Work", data["plasterWorkStatus"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildDataCell("Date", _formatDate(data["timestamp"]))),
                Expanded(child: _buildDataCell("Time", _formatTime(data["timestamp"]))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCell(String label, String? text) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        Expanded(
          child: Text(
            text ?? "N/A",
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  String _formatDate(String? timestamp) {
    if (timestamp == null) return "N/A";
    final dateTime = DateTime.parse(timestamp);
    return DateFormat('d MMM yyyy').format(dateTime);
  }

  String _formatTime(String? timestamp) {
    if (timestamp == null) return "N/A";
    final dateTime = DateTime.parse(timestamp);
    return DateFormat('h:mm a').format(dateTime);
  }
}
