import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/asphalt_work_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/asphalt_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, Inst;
import 'package:easy_localization/easy_localization.dart';
import 'asphalt_work_summary.dart';

class AsphaltWork extends StatefulWidget {
  const AsphaltWork({super.key});

  @override
  _AsphaltWorkState createState() => _AsphaltWorkState();
}

class _AsphaltWorkState extends State<AsphaltWork> {
  AsphaltWorkViewModel asphaltWorkViewModel = Get.put(AsphaltWorkViewModel());
  DBHelper dbHelper = DBHelper();
  int? asphaltId;
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  final List<String> streets = ["Street 1", "Street 2", "Street 3", "Street 4", "Street 5", "Street 6", "Street 7"];

  // Single container data for a single widget
  Map<String, dynamic> containerData = {
    "selectedBlock": null,
    "selectedStreet": null,
    "numTankers": '',
    "status": null,
  };

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
                    image: AssetImage('assets/images/rock-01.png'),
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
                    builder: (context) => AsphaltWorkSummary(),
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
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'asphalt_work'.tr(),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
              ),
            ),
            // Single widget, no more dynamically added widgets
            buildContainer(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildContainer() {
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
            buildBlockStreetRow(),
            const SizedBox(height: 16),
            Text(
              'no_of_tons'.tr(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: containerData["numTankers"],
              onChanged: (value) {
                setState(() {
                  containerData["numTankers"] = value;
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
            const SizedBox(height: 16),
            Text(
              'back_filing_status'.tr(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            const SizedBox(height: 8),
            buildStatusRadioButtons(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final selectedBlock = containerData["selectedBlock"];
                  final selectedStreet = containerData["selectedStreet"];
                  final numTankers = containerData["numTankers"];
                  final status = containerData["status"];
                  {
                    await asphaltWorkViewModel.addAsphalt(AsphaltWorkModel(
                      id: asphaltId,
                      block_no: selectedBlock,
                      street_no: selectedStreet,
                      no_of_tons: numTankers,
                      back_filling_status: status,
                      date: _getFormattedDate(),
                      time: _getFormattedTime(),
                    ));

                    await asphaltWorkViewModel.fetchAllAsphalt();
                    await asphaltWorkViewModel.postDataFromDatabaseToAPI();
                  }

                  // Clear the fields after submission
                  setState(() {
                    containerData = {
                      "selectedBlock": null,
                      "selectedStreet": null,
                      "numTankers": '',
                      "status": null,
                    };
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: $selectedBlock, $selectedStreet, Total Length: $numTankers, Backfilling Status: $status',
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

  Widget buildBlockStreetRow() {
    return Row(
      children: [
        Expanded(child: buildDropdownField('block_no'.tr(), "selectedBlock", blocks)),
        const SizedBox(width: 16),
        Expanded(child: buildDropdownField('street_no'.tr(), "selectedStreet", streets)),
      ],
    );
  }

  Widget buildDropdownField(String title, String key, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
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
            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFC69840))),
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ],
    );
  }

  Widget buildStatusRadioButtons() {
    return Column(
      children: [
        RadioListTile<String>(
          title: Text('in_process'.tr()),
          value: 'in_process'.tr(),
          groupValue: containerData["status"],
          onChanged: (value) {
            setState(() {
              containerData["status"] = value;
            });
          },
          activeColor: const Color(0xFFC69840),
        ),
        RadioListTile<String>(
          title: Text('done'.tr()),
          value: 'done'.tr(),
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
