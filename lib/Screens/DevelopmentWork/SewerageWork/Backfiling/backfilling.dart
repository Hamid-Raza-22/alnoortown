import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/back_filing_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/SewerageWorksViewModel/back_filling_view_model.dart';
import 'package:al_noor_town/Widgets/snackbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, GetNavigation, Inst, Obx;
import 'package:intl/intl.dart';
import '../../../../ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import '../../../../ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import '../../../../Widgets/custom_dropdown_widgets.dart';
import 'backfiling_summary.dart';

class Backfiling extends StatefulWidget {
  Backfiling({super.key});

  @override
  _BackfilingState createState() => _BackfilingState();
}

class _BackfilingState extends State<Backfiling> {

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
            buildBlockStreetRow(containerData, roadDetailsViewModel),
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
                  String status = containerData["status"];
                  if(selectedStreet!=null&& selectedStreet!=null &&status.isNotEmpty &&status!=null){
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
                  showSnackBarSuccessfully(context);
                  }else{
                    showSnackBarPleaseFill(context);
                  }
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


}
