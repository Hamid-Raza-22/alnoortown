import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_excavation_model.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/LightPolesWork/PolesExcavation/poles_excavation_summary.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/LightPolesWorkViewModel/poles_excavation_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import 'package:intl/intl.dart';

import '../../../../ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import '../../../../ViewModels/RoadDetailsViewModel/road_details_view_model.dart';

class PolesFoundation extends StatefulWidget {
  PolesFoundation({super.key});

  @override
  PolesFoundationState createState() => PolesFoundationState();
}

class PolesFoundationState extends State<PolesFoundation> {
  PolesExcavationViewModel polesExcavationViewModel = Get.put(PolesExcavationViewModel());
  BlockDetailsViewModel blockDetailsViewModel = Get.put(BlockDetailsViewModel());
  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());
  DBHelper dbHelper = DBHelper();
  int? exId;
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  final List<String> streets = ["Street 1", "Street 2", "Street 3", "Street 4", "Street 5", "Street 6", "Street 7"];
  Map<String, dynamic> containerData = {};

  @override
  void initState() {
    super.initState();
    containerData = createInitialContainerData();
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedBlock": null,
      "selectedStreet": null,
      "polesExcavation": '',
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
        preferredSize: Size.fromHeight(180.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/pol-01.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFC69840)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.summarize, color: Color(0xFFC69840)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PolesExcavationSummary(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'poles_excavation_work'.tr(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
              ),
            ),
            buildContainer(),
          ],
        ),
      ),
    );
  }

  Widget buildContainer() {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockStreetRow(containerData),
            SizedBox(height: 16),
            Text(
              "no_of_poles_excavation".tr(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            SizedBox(height: 8),
            TextFormField(
              initialValue: containerData["polesExcavation"],
              onChanged: (value) {
                setState(() {
                  containerData["polesExcavation"] = value;
                });
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
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
                  final polesExcavation = containerData["polesExcavation"];
                  await polesExcavationViewModel.addPoleExa(PolesExcavationModel(
                    id: exId,
                    block_no: selectedBlock,
                    street_no: selectedStreet,
                    no_of_excavation: polesExcavation,
                    date: _getFormattedDate(),
                    time: _getFormattedTime(),
                  ));
                  await polesExcavationViewModel.fetchAllPoleExa();

                  // Clear fields after submission
                  setState(() {
                    containerData = createInitialContainerData();
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: $selectedBlock, $selectedStreet, No. of Excavation: $polesExcavation',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF3F4F6),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text('submit'.tr(), style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildDropdownField(String title, Map<String, dynamic> containerData, String key, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        SizedBox(height: 8),
        DropdownSearch<String>(
          items: items,
          selectedItem: containerData[key],
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF4A4A4A)),
                borderRadius: BorderRadius.circular(8), // Slightly larger border radius
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // More padding for a cleaner look
            ),
          ),
          popupProps: PopupProps.menu(
            showSearchBox: true, // Enables the search feature
            itemBuilder: (context, item, isSelected) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 11), // Slightly larger font for dropdown items
                ),
              );
            },
          ),
          onChanged: (value) {
            setState(() {
              containerData[key] = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildBlockStreetRow(Map<String, dynamic> containerData) {
    return Obx(() {
      // Dynamically get the blocks list from the BlockDetailsViewModel
      final List<String> blocks = blockDetailsViewModel.allBlockDetails
          .map((blockDetail) => blockDetail.block.toString())
          .toSet()
          .toList();
      // Dynamically get the streets list from the BlockDetailsViewModel
      final List<String> streets = roadDetailsViewModel.allRoadDetails
          .map((streetDetail) => streetDetail.street.toString())
          .toSet()
          .toList();

      return Row(
        children: [
          Expanded(
            child: buildDropdownField(
                "block_no".tr(),containerData,  "selectedBlock", blocks),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: buildDropdownField(
                "street_no".tr(),containerData,  "selectedStreet", streets),
          ),
        ],
      );
    });
  }
}
