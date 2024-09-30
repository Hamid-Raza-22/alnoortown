import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/plaster_work_model.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/MainDrainWork/PlasterWork/plaster_work_summary.dart';
import 'package:al_noor_town/ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/plaster_work_view_model.dart';
import 'package:al_noor_town/ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import 'package:intl/intl.dart';

class PlasterWork extends StatefulWidget {
  PlasterWork({super.key});

  @override
  PlasterWorkState createState() => PlasterWorkState();
}

class PlasterWorkState extends State<PlasterWork> {
  PlasterWorkViewModel plasterWorkViewModel = Get.put(PlasterWorkViewModel());
  BlockDetailsViewModel blockDetailsViewModel = Get.put(BlockDetailsViewModel());
  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());
  DBHelper dbHelper = DBHelper();
  int? plasterId;
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  final List<String> streets = ["Street 1", "Street 2", "Street 3", "Street 4", "Street 5", "Street 6", "Street 7"];

  Map<String, dynamic> containerData = {
    "selectedBlock": null,
    "selectedStreet": null,
    "numTankers": '',
  };

  @override
  void initState() {
    super.initState();
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedBlock": null,
      "selectedStreet": null,
      "numTankers": '',
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
                    image: AssetImage('assets/images/plasterrr-01.png'),
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
                    builder: (context) => PlasterWorkSummary(),
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
                  'plaster_work'.tr(),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
              ),
            ),
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
            buildBlockStreetRow(containerData),
            const SizedBox(height: 16),
            Text(
              'total_length_completed'.tr(),
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
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final selectedBlock = containerData["selectedBlock"];
                  final selectedStreet = containerData["selectedStreet"];
                  final numTankers = containerData["numTankers"];

                  await plasterWorkViewModel.addMan(PlasterWorkModel(
                      id: plasterId,
                      block_no: selectedBlock,
                      street_no: selectedStreet,
                      completed_length: numTankers,
                      date: _getFormattedDate(),
                      time: _getFormattedTime()
                  ));
                  await plasterWorkViewModel.fetchAllPlaster();
                  await plasterWorkViewModel.postDataFromDatabaseToAPI();

                  setState(() {
                    containerData = createInitialContainerData(); // Clear the fields
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: $selectedBlock, $selectedStreet, No. of Tankers: $numTankers',
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
