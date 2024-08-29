import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/mosque_excavation_work.dart';
import 'package:al_noor_town/ViewModels/BuidingWorkViewModel/mosque_excavation_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'MosqueSummaryPage.dart';

class MosqueExcavationWork extends StatefulWidget {
  const MosqueExcavationWork({super.key});

  @override
  MosqueExcavationWorkState createState() => MosqueExcavationWorkState();
}

class MosqueExcavationWorkState extends State<MosqueExcavationWork> {
  MosqueExcavationViewModel mosqueExcavationViewModel = Get.put(MosqueExcavationViewModel());
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
   // _loadData();
  }

  // // Load data specific to excavation work from SharedPreferences
  // Future<void> _loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? savedData = prefs.getString('excavationWorkDataList'); // Unique key for excavation work
  //   if (savedData != null) {
  //     setState(() {
  //       containerDataList =
  //       List<Map<String, dynamic>>.from(json.decode(savedData));
  //     });
  //   }
  // }
  //
  // // Save data specific to excavation work to SharedPreferences
  // Future<void> _saveData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('excavationWorkDataList', json.encode(containerDataList)); // Unique key for excavation work
  // }
  //
  // Map<String, dynamic> createNewEntry() {
  //   return {
  //     "selectedBlock": selectedBlock,
  //     "status": selectedStatus,
  //     "timestamp": DateTime.now().toIso8601String(),
  //   };
  // }

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
                      MosqueSummaryPage(containerDataList: containerDataList),
                ),
              );
            },
          ),
        ],
        title: const Text(
          'Mosque Excavation Work',
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
              'assets/images/mosqueExcavationWork.png',
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
              "Excavation Completion Status:",
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
                    await mosqueExcavationViewModel.addMosque(MosqueExcavationWorkModel(
                      blockNo: selectedBlock,
                      completionStatus: selectedStatus,
                     // date:
                    ));
                    await mosqueExcavationViewModel.fetchAllMosque();
                    // Map<String, dynamic> newEntry =
                    // createNewEntry();

                    // setState(() {
                    //   containerDataList.add(newEntry);
                    // });

                    void showSnackBar(String message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    }
                  //  await _saveData();

                    // Call the callback after the async operation
                    showSnackBar('Entry added successfully!');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please select a block and status.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F4F6),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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


