
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/foundation_work_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/foundation_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'FoundationSummaryPage.dart';

class FoundationWork extends StatefulWidget {
  const FoundationWork({super.key});

  @override
  FoundationWorkState createState() => FoundationWorkState();
}

class FoundationWorkState extends State<FoundationWork> {
  FoundationWorkViewModel foundationWorkViewModel = Get.put(FoundationWorkViewModel());
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
  }
  String _getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('d MMM yyyy');
    return formatter.format(now);
  }  String _getFormattedTime() {
    final now = DateTime.now();
    final formatter = DateFormat('h:mm a');
    return formatter.format(now);
  }
  // Future<void> _loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? savedData = prefs.getString('foundationWorkDataList'); // Unique key for Foundation Work
  //   if (savedData != null) {
  //     setState(() {
  //       containerDataList =
  //       List<Map<String, dynamic>>.from(json.decode(savedData));
  //     });
  //   }
  // }
  //
  // Future<void> _saveData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('foundationWorkDataList', json.encode(containerDataList)); // Unique key for Foundation Work
  // }
  //
  // Map<String, dynamic> createNewEntry(String? selectedBlock, String? brickStatus, String? mudStatus, String? plasterStatus) {
  //   return {
  //     "selectedBlock": selectedBlock,
  //     "brickWorkStatus": brickStatus,
  //     "mudFillingStatus": mudStatus,
  //     "plasterWorkStatus": plasterStatus,
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
                      FoundationSummaryPage(containerDataList: containerDataList),
                ),
              );
            },
          ),
        ],
        title: const Text(
          'Mosque Foundation Work',
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
            buildStatusColumn(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedBlock != null && selectedBrickWorkStatus != null && selectedMudFillingStatus != null && selectedPlasterWorkStatus != null) {
                      await foundationWorkViewModel.addFoundation(FoundationWorkModel(
                        blockNo: selectedBlock,
                        brickWork: selectedBrickWorkStatus,
                        mudFiling: selectedMudFillingStatus,
                        plasterWork: selectedPlasterWorkStatus,
                          date: _getFormattedDate(),
                          time: _getFormattedTime()
                      ));
                      await foundationWorkViewModel.fetchAllFoundation();
                    void showSnackBar(String message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    }


                    // Call the callback after the async operation
                    showSnackBar('Entry added successfully!');
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


