import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'MP_Mudfilling_Summary.dart';

class MiniParkMudFilling extends StatefulWidget {
  const MiniParkMudFilling({super.key});

  @override
  _MiniParkMudFillingState createState() => _MiniParkMudFillingState();
}

class _MiniParkMudFillingState extends State<MiniParkMudFilling> {
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TextEditingController dumpersController = TextEditingController();
  String? selectedStatus;
  List<Map<String, dynamic>> containerDataList = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedData = prefs.getString('excavationWorkDataList');
    if (savedData != null) {
      setState(() {
        containerDataList = List<Map<String, dynamic>>.from(json.decode(savedData));
      });
    }
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('excavationWorkDataList', json.encode(containerDataList));
  }

  Map<String, dynamic> createNewEntry(DateTime? startDate, DateTime? endDate, String? dumpers, String? status) {
    return {
      "startDate": startDate?.toIso8601String(),
      "endDate": endDate?.toIso8601String(),
      "dumpers": dumpers,
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
                      MPMudFillingSummary(containerDataList: containerDataList),
                ),
              );
            },
          ),
        ],
        title: const Text(
          'Mud Filling Work',
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
            buildDatePickerRow(
              "Start Date:",
              selectedStartDate,
                  (date) => setState(() => selectedStartDate = date),
            ),
            const SizedBox(height: 16),
            buildDatePickerRow(
              "Expected Completion Date:",
              selectedEndDate,
                  (date) => setState(() => selectedEndDate = date),
            ),
            const SizedBox(height: 16),
            buildTextFieldRow("Total Dumpers:", dumpersController),
            const SizedBox(height: 16),
            const Text(
              "Mud Filling Completion Status:",
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
                  if (selectedStartDate != null &&
                      selectedEndDate != null &&
                      dumpersController.text.isNotEmpty &&
                      selectedStatus != null) {
                    Map<String, dynamic> newEntry = createNewEntry(
                      selectedStartDate,
                      selectedEndDate,
                      dumpersController.text,
                      selectedStatus,
                    );

                    setState(() {
                      containerDataList.add(newEntry);
                      selectedStartDate = null;
                      selectedEndDate = null;
                      selectedStatus = null;
                      dumpersController.clear();
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
                        content: Text('Please fill in all fields.'),
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

  Widget buildDatePickerRow(String label, DateTime? selectedDate, ValueChanged<DateTime?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC69840)),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            onChanged(pickedDate);
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFC69840)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              selectedDate != null
                  ? DateFormat('d MMM yyyy').format(selectedDate)
                  : 'Select Date',
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFFC69840),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextFieldRow(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC69840)),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
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






