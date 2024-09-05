import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/asphalt_work_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/asphalt_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, Inst;
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';

class AsphaltWork extends StatefulWidget {
    AsphaltWork({super.key});

  @override
  _AsphaltWorkState createState() => _AsphaltWorkState();
}

class _AsphaltWorkState extends State<AsphaltWork>  {
  AsphaltWorkViewModel asphaltWorkViewModel=Get.put(AsphaltWorkViewModel());
  DBHelper dbHelper = DBHelper();
  int? asphaltId;
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  final List<String> streets = ["Street 1", "Street 2", "Street 3", "Street 4", "Street 5", "Street 6", "Street 7"];
  List<Map<String, dynamic>> containerDataList = [];

  @override
  void initState() {
    super.initState();
    containerDataList.add(createInitialContainerData());
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedBlock": null,
      "selectedStreet": null,
      "numTankers": '',
      "status": null,
    };
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
      appBar: PreferredSize(
        preferredSize:   Size.fromHeight(180.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            width: double.infinity,
            height: double.infinity,
            decoration:   BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/rock-01.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      body: SingleChildScrollView(
        padding:   EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'asphalt_work'.tr(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
              ),
            ),
            ...containerDataList.asMap().entries.map((entry) {
              return Column(
                children: [
                  buildContainer(entry.key),
                    SizedBox(height: 16),
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
                child:   Icon(Icons.add, color: Color(0xFFC69840), size: 36.0),
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
      margin:   EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding:   EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockStreetRow(containerData),
              SizedBox(height: 16),
              Text(
              'no_of_tons'.tr(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
              SizedBox(height: 8),
            TextFormField(
              initialValue: containerData["numTankers"],
              onChanged: (value) {
                setState(() {
                  containerData["numTankers"] = value;
                });
              },
              keyboardType: TextInputType.number,
              decoration:   InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC69840)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
              SizedBox(height: 16),
              Text(
              'back_filing_status'.tr(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
              SizedBox(height: 8),
            buildStatusRadioButtons(containerData),
              SizedBox(height: 20),
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
                      blockNo: selectedBlock,
                      streetNo: selectedStreet,
                      numOfTons: numTankers,
                      backFillingStatus: status,
                        date: _getFormattedDate(),
                        time: _getFormattedTime()
                    ));

                    await asphaltWorkViewModel.fetchAllAsphalt();
                  }


                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: $selectedBlock, $selectedStreet, Total Length: $numTankers, Backfilling Status: $status',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:   Color(0xFFF3F4F6),
                  padding:   EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle:   TextStyle(fontSize: 14),
                  shape:   RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child:   Text('submit'.tr(), style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
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
        Expanded(child: buildDropdownField('block_no'.tr(), containerData, "selectedBlock", blocks)),
          SizedBox(width: 16),
        Expanded(child: buildDropdownField('street_no'.tr(), containerData, "selectedStreet", streets)),
      ],
    );
  }

  Widget buildDropdownField(String title, Map<String, dynamic> containerData, String key, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style:   TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
          SizedBox(height: 8),
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
          decoration:   InputDecoration(
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
          title: Text('in_process'.tr()),  // Corrected by adding parentheses
          value: 'in_process'.tr(),
          groupValue: containerData["status"],
          onChanged: (value) {
            setState(() {
              containerData["status"] = value;
            });
          },
          activeColor: Color(0xFFC69840),
        ),
        RadioListTile<String>(
          title: Text('done'.tr()),  // This was already correct
          value: 'done'.tr(),
          groupValue: containerData["status"],
          onChanged: (value) {
            setState(() {
              containerData["status"] = value;
            });
          },
          activeColor: Color(0xFFC69840),
        ),
      ],
    );
  }

}
