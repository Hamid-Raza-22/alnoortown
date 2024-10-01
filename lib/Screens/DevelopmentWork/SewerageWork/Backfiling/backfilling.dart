import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/back_filing_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/SewerageWorksViewModel/back_filling_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, GetNavigation, Inst, Obx;
import 'package:intl/intl.dart';
import '../../../../ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import '../../../../ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import 'backfiling_summary.dart';

class Backfiling extends StatefulWidget {
  Backfiling({super.key});

  @override
  _BackfilingState createState() => _BackfilingState();
}

class _BackfilingState extends State<Backfiling> {
  BlockDetailsViewModel blockDetailsViewModel = Get.put(BlockDetailsViewModel());
  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());
  BackFillingViewModel backFillingViewModel = Get.put(BackFillingViewModel());
  DBHelper dbHelper = DBHelper();
  int? fillingId;

  Map<String, dynamic> containerData = {
    "selectedBlock": null,
    "selectedStreet": null,
    "status": "",
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
                    image: AssetImage('assets/images/curbstone.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFC69840)), // Gold color for back icon
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.summarize, color: Color(0xFFC69840)), // Gold color for summarize icon
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BackfillingSummary(
                    ),
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
                  'back_filing'.tr(),
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
            buildBlockStreetRow(),
            const SizedBox(height: 16),
            Text(
              "status".tr(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('in_process'.tr()),
                    value: 'in_process'.tr(),
                    groupValue: containerData["status"],
                    onChanged: (String? value) {
                      setState(() {
                        containerData["status"] = value;
                      });
                    },
                    activeColor: const Color(0xFFC69840),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text('done'.tr()),
                    value: 'done'.tr(),
                    groupValue: containerData["status"],
                    onChanged: (String? value) {
                      setState(() {
                        containerData["status"] = value;
                      });
                    },
                    activeColor: const Color(0xFFC69840),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final selectedBlock = containerData["selectedBlock"];
                  final selectedStreet = containerData["selectedStreet"];
                  final status = containerData["status"];

                  // Submit data
                  await backFillingViewModel.addFill(BackFilingModel(
                    id: fillingId,
                    block_no: selectedBlock,
                    street_no: selectedStreet,
                    status: status,
                    date: _getFormattedDate(),
                    time: _getFormattedTime(),
                    user_id: userId
                  ));
                  await backFillingViewModel.fetchAllFill();
                  await backFillingViewModel.postDataFromDatabaseToAPI();

                  // Clear fields after submission
                  setState(() {
                    containerData = {
                      "selectedBlock": null,
                      "selectedStreet": null,
                      "status": "",
                    };
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Selected: $selectedBlock, $selectedStreet, Backfiling Status: $status'),
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
            child: buildDropdownField("block_no".tr(), "selectedBlock", blocks),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: buildDropdownField(
                "street_no".tr(), "selectedStreet", streets),
          ),
        ],
      );
    });
  }
  Widget buildDropdownField(String title, String key, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14, // Slightly larger font size for the title
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840), // More neutral color for a professional look
          ),
        ),
        const SizedBox(height: 8), // Increased vertical space for better readability
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
                  style: const TextStyle(fontSize: 14), // Slightly larger font for dropdown items
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

}
