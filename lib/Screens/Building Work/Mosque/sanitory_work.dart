import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SanitaryWork extends StatefulWidget {
  const SanitaryWork({super.key});

  @override
  _SanitaryWorkState createState() => _SanitaryWorkState();
}

class _SanitaryWorkState extends State<SanitaryWork> {
  final List<String> blocks = [
    "Block A",
    "Block B",
    "Block C",
    "Block D",
    "Block E",
    "Block F",
    "Block G"
  ];
  List<Map<String, dynamic>> sanitorycontainerDataList = [];

  String? selectedBlock;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _loadData(); // Load data when the widget initializes
  }

  // Load data using a unique key for this page
  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('sanitaryWorkDataList'); // Changed key
    if (savedData != null) {
      setState(() {
        sanitorycontainerDataList = List<Map<String, dynamic>>.from(json.decode(savedData));
      });
    }
  }

  // Save data using a unique key for this page
  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sanitaryWorkDataList', json.encode(sanitorycontainerDataList)); // Changed key
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
        elevation: 0,
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
                  builder: (context) => SanitaryWorkSummary(containerDataList: sanitorycontainerDataList),
                ),
              );
            },
          ),
        ],
        title: const Text(
          'Sanitary Work',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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
              "Sanitary Work Status:",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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
                    Map<String, dynamic> newEntry = createNewEntry(selectedBlock, selectedStatus);

                    setState(() {
                      sanitorycontainerDataList.add(newEntry);
                    });

                    await _saveData();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Entry added successfully!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select a block and status.')),
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
                child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
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
        const Text("Block No.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
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
            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFC69840))),
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
class SanitaryWorkSummary extends StatelessWidget {
  final List<Map<String, dynamic>> containerDataList;

  const SanitaryWorkSummary({super.key, required this.containerDataList});

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
          'Sanitary Work Summary',
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
              color: const Color(0xFFC69840),
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
        border: Border.all(color: const Color(0xFFC69840), width: 1.0),
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
