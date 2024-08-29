import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'MainGateFoundationSummary.dart';

class MainGateFoundationWork extends StatefulWidget {
  const MainGateFoundationWork({super.key});

  @override
  _MainGateFoundationWorkState createState() => _MainGateFoundationWorkState();
}

class _MainGateFoundationWorkState extends State<MainGateFoundationWork> {
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
  String? workStatus;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('MainGateFoundationDataList');
    if (savedData != null) {
      setState(() {
        containerDataList = List<Map<String, dynamic>>.from(json.decode(savedData));
      });
    }
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('MainGateFoundationDataList', json.encode(containerDataList));
  }

  Map<String, dynamic> createNewEntry(String? selectedBlock, String? workStatus) {
    return {
      "selectedBlock": selectedBlock,
      "workStatus": workStatus,
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
                  builder: (context) => MainGateFoundationSummary(containerDataList: containerDataList),
                ),
              );
            },
          ),
        ],
        title: const Text(
          ' Main Gate Foundation',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/mosqueExcavationwork.png',
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
            buildWorkStatusField(),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedBlock != null && workStatus != null) {
                    Map<String, dynamic> newEntry = createNewEntry(selectedBlock, workStatus);

                    setState(() {
                      containerDataList.add(newEntry);
                    });

                    await _saveData();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Entry added successfully!'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill all the fields.'),
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
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
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
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
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

  Widget buildWorkStatusField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Work Status",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
        const SizedBox(height: 8),
        TextField(
          onChanged: (value) {
            setState(() {
              workStatus = value;
            });
          },
          maxLines: 3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFC69840))),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          ),
        ),
      ],
    );
  }
}

