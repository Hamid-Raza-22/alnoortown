import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CeilingWork extends StatefulWidget {
  const CeilingWork({super.key});

  @override
  _CeilingWorkState createState() => _CeilingWorkState();
}

class _CeilingWorkState extends State<CeilingWork> {
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
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('ceilingWorkDataList'); // Unique key for Ceiling Work
    if (savedData != null) {
      setState(() {
        containerDataList =
        List<Map<String, dynamic>>.from(json.decode(savedData));
      });
    }
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('ceilingWorkDataList', json.encode(containerDataList)); // Unique key for Ceiling Work
  }

  Map<String, dynamic> createNewEntry(String? selectedBlock, String? status) {
    return {
      "selectedBlock": selectedBlock,
      "status": status,
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
          icon: Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.history_edu_outlined, color: Color(0xFFC69840)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CeilingWorkSummary(containerDataList: containerDataList),
                ),
              );
            },
          ),
        ],
        title: const Text(
          'Ceiling Work',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/mosqueexavationwork.png',
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
            const Text(
              "Ceiling Work Status:",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC69840)),
            ),
            const SizedBox(height: 8),
            buildStatusRadioButtons((value) {
              setState(() {
                selectedStatus = value;
              });
            }),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedBlock != null && selectedStatus != null) {
                    // Create a new entry
                    Map<String, dynamic> newEntry = createNewEntry(selectedBlock, selectedStatus);

                    // Add the new entry to the list
                    setState(() {
                      containerDataList.add(newEntry);
                    });

                    // Save the updated list to SharedPreferences
                    await _saveData();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Entry added successfully!'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select a block and status.'),
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
        Text("Block No.",
            style: const TextStyle(
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

  Widget buildStatusRadioButtons(ValueChanged<String?> onChanged) {
    return Column(
      children: [
        RadioListTile<String>(
          title: const Text('In Process'),
          value: 'In Process',
          groupValue: selectedStatus,
          onChanged: onChanged,
          activeColor: const Color(0xFFC69840),
        ),
        RadioListTile<String>(
          title: const Text('Done'),
          value: 'Done',
          groupValue: selectedStatus,
          onChanged: onChanged,
          activeColor: const Color(0xFFC69840),
        ),
      ],
    );
  }
}

class CeilingWorkSummary extends StatelessWidget {
  final List<Map<String, dynamic>> containerDataList;

  const CeilingWorkSummary({super.key, required this.containerDataList});

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
          'Ceiling Work Summary',
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
            // Table Header
            Container(
              color: Color(0xFFC69840),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: _buildHeaderCell("Block No")),
                    Expanded(child: _buildHeaderCell("Status")),
                    Expanded(child: _buildHeaderCell("Date")),
                    Expanded(child: _buildHeaderCell("Time")),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
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
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDataRow(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFC69840), width: 1.0),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: _buildDataCell(data["selectedBlock"] ?? "N/A")),
            Expanded(child: _buildDataCell(data["status"] ?? "N/A")),
            Expanded(child: _buildDataCell(_formatDate(data["timestamp"]))),
            Expanded(child: _buildDataCell(_formatTime(data["timestamp"]))),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCell(String? text) {
    return Center(
      child: Text(
        text ?? "N/A",
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFFC69840),
        ),
      ),
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
