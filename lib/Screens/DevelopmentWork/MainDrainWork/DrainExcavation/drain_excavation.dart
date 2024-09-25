import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/main_drain_excavation_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/main_drain_excavation_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, Inst;
import 'drain_excavation_summary.dart';

class DrainExcavation extends StatefulWidget {
  const DrainExcavation({super.key});

  @override
  _DrainExcavationState createState() => _DrainExcavationState();
}

class _DrainExcavationState extends State<DrainExcavation> {
  MainDrainExcavationViewModel mainDrainExcavationViewModel = Get.put(MainDrainExcavationViewModel());
  DBHelper dbHelper = DBHelper();
  int? drainId;
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  final List<String> streets = ["Street 1", "Street 2", "Street 3", "Street 4", "Street 5", "Street 6", "Street 7"];
  List<Map<String, dynamic>> containerDataList = [createInitialContainerData()];

  static Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedBlock": null,
      "selectedStreet": null,
      "totalcompleted_length": null,

    };
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('d MMM yyyy');
    return formatter.format(now);
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    final formatter = DateFormat('h:mm a');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/maindrain-01.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFC69840)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.summarize, color: Color(0xFFC69840)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DrainExcavationSummary(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 1),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'main_drain_excavation'.tr(),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
              ),
            ),
            ...containerDataList.asMap().entries.map((entry) {
              int index = entry.key;
              return Column(
                children: [
                  buildContainer(index),
                  const SizedBox(height: 16),
                ],
              );
            }),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  for (var containerData in containerDataList) {
                    final selectedBlock = containerData["selectedBlock"];
                    final selectedStreet = containerData["selectedStreet"];
                    final totalcompleted_length = containerData["totalcompleted_length"];

                    await mainDrainExcavationViewModel.addWork(
                        MainDrainExcavationModel(
                            id: drainId,
                            block_no: selectedBlock,
                            street_no: selectedStreet,
                            completed_length: totalcompleted_length,
                            date: _getFormattedDate(),
                            time: _getFormattedTime()
                        ));

                    await mainDrainExcavationViewModel.fetchAllDrain();
                  }

                  // Clear all fields
                  setState(() {
                    containerDataList = [createInitialContainerData()];
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: ${containerDataList[0]["selectedBlock"]}, ${containerDataList[0]["selectedStreet"]}, Total Lengths: ${containerDataList[0]["totalcompleted_length"]}',
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
                child: Text('submit'.tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
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
            buildBlockStreetRow(containerData),
            const SizedBox(height: 16),
            Text(
              'total_length_completed'.tr(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: containerData["totalcompleted_length"],
              onChanged: (value) {
                setState(() {
                  containerData["totalcompleted_length"] = value;
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC69840)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
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
              'block_no'.tr(), containerData, "selectedBlock", blocks
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: buildDropdownField(
              'street_no'.tr(), containerData, "selectedStreet", streets
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
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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
}
