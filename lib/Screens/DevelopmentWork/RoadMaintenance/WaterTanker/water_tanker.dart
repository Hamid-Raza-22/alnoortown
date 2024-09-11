import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/tanker_model.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/RoadMaintenance/WaterTanker/watertanker_summary.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/RoadMaintenaceViewModel/tanker_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, Inst;

class WaterTanker extends StatefulWidget {
    WaterTanker({super.key});

  @override
  _WaterTankerState createState() => _WaterTankerState();
}

class _WaterTankerState extends State<WaterTanker>  {
  TankerViewModel tankerViewModel = Get.put(TankerViewModel());
  DBHelper dbHelper = DBHelper();
  int? tankerId;
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  final List<String> streets = ["Street 1", "Street 2", "Street 3", "Street 4", "Street 5", "Street 6", "Street 7"];

  Map<String, dynamic> containerData = {
    "selectedBlock": null,
    "selectedStreet": null,
    "selectedTankers": null,
  };
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
          flexibleSpace: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration:   BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/waterr-01.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          actions: [
            IconButton(
              icon:   Icon(Icons.summarize, color: Color(0xFFC69840)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   WaterTankerSummary()),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding:   EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              SizedBox(height: 1),
              Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'water_tanker'.tr(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
              ),
            ),
            buildContainer(),
              SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildContainer() {
    return Card(
      margin:   EdgeInsets.only(bottom: 16),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding:   EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockStreetRow(),
              SizedBox(height: 16),
              Text(
              'no_of_tankers'.tr(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
              SizedBox(height: 8),
            DropdownButtonFormField<int>(
              value: containerData["selectedTankers"],
              items: List.generate(10, (index) => index + 1).map((number) {
                return DropdownMenuItem(
                  value: number,
                  child: Text(number.toString()),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  containerData["selectedTankers"] = value;
                });
              },
              decoration:   InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC69840)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
              SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final selectedBlock = containerData["selectedBlock"];
                  final selectedStreet = containerData["selectedStreet"];
                  final selectedTankers = containerData["selectedTankers"];
                  await tankerViewModel.addTanker(TankerModel(
                    id: tankerId,
                    blockNo: selectedBlock,
                    streetNo: selectedStreet,
                    tankerNo: selectedTankers,
                      date: _getFormattedDate(),
                      time: _getFormattedTime()
                  ));
                  await tankerViewModel.fetchAllTanker();

                  setState(() {
                    containerData["selectedBlock"] = null;
                    containerData["selectedStreet"] = null;
                    containerData["selectedTankers"] = null;

                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: $selectedBlock, $selectedStreet, No. of Tankers: $selectedTankers',
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

  Widget buildBlockStreetRow() {
    return Row(
      children: [
        Expanded(
          child: buildDropdownField('block_no'.tr(), "selectedBlock", blocks),
        ),
          SizedBox(width: 16),
        Expanded(
          child: buildDropdownField('street_no'.tr(), "selectedStreet", streets),
        ),
      ],
    );
  }

  Widget buildDropdownField(String title, String key, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:   TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
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
