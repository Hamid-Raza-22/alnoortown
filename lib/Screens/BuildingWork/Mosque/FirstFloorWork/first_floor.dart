import 'package:easy_localization/easy_localization.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/Mosque/first_floor_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/first_floor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import 'package:intl/intl.dart';
import 'FirstFloorSummaryPage.dart';

class FirstFloorWork extends StatefulWidget {
    FirstFloorWork({super.key});

  @override
  FirstFloorWorkState createState() => FirstFloorWorkState();
}

class FirstFloorWorkState extends State<FirstFloorWork> {
  FirstFloorViewModel firstFloorViewModel = Get.put(FirstFloorViewModel());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:   Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon:   Icon(Icons.history_edu_outlined, color: Color(0xFFC69840)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FirstFloorSummaryPage(),
                ),
              );
            },
          ),
        ],
        title:   Text(
          'first_floor'.tr(),
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
              padding:   EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildContainer(),
                    SizedBox(height: 16),
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
      margin:   EdgeInsets.only(bottom: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding:   EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockRow((value) {
              setState(() {
                selectedBlock = value;
              });
            }),
              SizedBox(height: 16),
            buildStatusColumn(),
              SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedBlock != null && selectedBrickWorkStatus != null && selectedMudFillingStatus != null && selectedPlasterWorkStatus != null) {
                    await firstFloorViewModel.addFirstFloor(FirstFloorModel(
                      block_no: selectedBlock,
                      brickWork: selectedBrickWorkStatus,
                      mudFiling: selectedMudFillingStatus,
                      plasterWork: selectedPlasterWorkStatus,
                        date: _getFormattedDate(),
                        time: _getFormattedTime()
                    ));
                    await firstFloorViewModel.fetchAllFirstFloor();
                    void showSnackBar(String message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                        ),
                      );
                    }


                    // Call the callback after the async operation
                    showSnackBar('entry_added_successfully'.tr());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                        content: Text('Please select all statuses.'),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:   Color(0xFFF3F4F6),
                  padding:   EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle:   TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child:   Text('submit'.tr().tr(),
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
          Text('block_no'.tr(),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC69840))),
          SizedBox(height: 8),
        DropdownButtonFormField<String>(
          items: blocks.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          decoration:   InputDecoration(
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
        buildStatusRow('brick_work'.tr(), selectedBrickWorkStatus, (value) {
          setState(() {
            selectedBrickWorkStatus = value;
          });
        }),
        buildStatusRow('mud_filling_work'.tr(), selectedMudFillingStatus, (value) {
          setState(() {
            selectedMudFillingStatus = value;
          });
        }),
        buildStatusRow('plaster_work'.tr(), selectedPlasterWorkStatus, (value) {
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
        Text(title, style:   TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
        Row(
          children: [
            buildRadioButton('in_process'.tr(), groupValue, onChanged),
            buildRadioButton('done'.tr(), groupValue, onChanged),
          ],
        ),
          SizedBox(height: 16), // Adds space between rows
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
          activeColor:   Color(0xFFC69840),
        ),
        Text(title, style:   TextStyle(fontSize: 12)),
      ],
    );
  }
}


