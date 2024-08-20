import 'package:al_noor_town/Database/dbhelper.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/mosque_exavation_work.dart';
import 'package:al_noor_town/ViewModels/BuidingWorkViewModel/mosque_exavation_view_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MosqueExavationWork extends StatefulWidget {
  const MosqueExavationWork({super.key});

  @override
  _MosqueExavationWorkState createState() => _MosqueExavationWorkState();
}

class _MosqueExavationWorkState extends State<MosqueExavationWork> {
  MosqueExavationViewMode mosqueExavationViewMode=Get.put(MosqueExavationViewMode());
  DBHelper dbHelper = DBHelper();
  int? mosqueId;
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  List<Map<String, dynamic>> containerDataList = [];

  @override
  void initState() {
    super.initState();
    containerDataList.add(createInitialContainerData());
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedBlock": null,
      "status": null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/lightwire-01.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Mosque Exavation Work',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
              ),
            ),
            ...containerDataList.asMap().entries.map((entry) {
              return Column(
                children: [
                  buildContainer(entry.key),
                  const SizedBox(height: 16),
                ],
              );
            }),
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    containerDataList.add(createInitialContainerData());
                  });
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: const Icon(Icons.add, color: Color(0xFFC69840), size: 36.0),
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockRow(containerData),
            const SizedBox(height: 16),
            const Text(
              "Completion Status:",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            const SizedBox(height: 8),
            buildStatusRadioButtons(containerData),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final selectedBlock = containerData["selectedBlock"];
                  final completionStatus = containerData["completionStatus"];

                  await mosqueExavationViewMode.addMosque(MosqueExavationWorkModel(
                    id: mosqueId,
                    blockNo: selectedBlock,
                    completionStatus: completionStatus,

                  ));
                  // await dbHelper.showAsphaltData();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: $selectedBlock, Backfilling completionStatus: $completionStatus',
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
                child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBlockRow(Map<String, dynamic> containerData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Block No.", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: containerData["selectedBlock"],
          items: blocks.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              containerData["selectedBlock"] = value;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFC69840))),
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ],
    );
  }

  Widget buildStatusRadioButtons(Map<String, dynamic> containerData) {
    return Column(
      children: [
        RadioListTile<String>(
          title: const Text('In Process'),
          value: 'In Process',
          groupValue: containerData["status"],
          onChanged: (value) {
            setState(() {
              containerData["status"] = value;
            });
          },
          activeColor: const Color(0xFFC69840),
        ),
        RadioListTile<String>(
          title: const Text('Done'),
          value: 'Done',
          groupValue: containerData["status"],
          onChanged: (value) {
            setState(() {
              containerData["status"] = value;
            });
          },
          activeColor: const Color(0xFFC69840),
        ),
      ],
    );
  }
}
