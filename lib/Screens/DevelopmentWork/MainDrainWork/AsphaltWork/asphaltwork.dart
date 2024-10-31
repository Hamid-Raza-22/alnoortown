import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/MainDrainWorksModels/asphalt_work_model.dart';
import 'package:al_noor_town/ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/asphalt_work_view_model.dart';
import 'package:al_noor_town/ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, Inst;
import 'package:easy_localization/easy_localization.dart';
import '../../../../Widgets/custom_dropdown_widgets.dart';
import '../../../../Widgets/snackbar.dart';
import 'asphalt_work_summary.dart';
import 'package:get/get.dart' show Get, Inst, Obx;

class AsphaltWork extends StatefulWidget {
  const AsphaltWork({super.key});

  @override
  _AsphaltWorkState createState() => _AsphaltWorkState();
}

class _AsphaltWorkState extends State<AsphaltWork> {

  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());
  AsphaltWorkViewModel asphaltWorkViewModel = Get.put(AsphaltWorkViewModel());
  DBHelper dbHelper = DBHelper();
  int? asphaltId;

  TextEditingController totalCOntroller = TextEditingController();
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
      "numTanker":null,
      "status":null
    };
  }
  void _clearFields() {
    setState(() {
      containerData = createInitialContainerData();
      totalCOntroller.clear(); // Clear the controller's text
    });
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
            buildBlockStreetRow(containerData, roadDetailsViewModel),
            const SizedBox(height: 16),
            Text(
              'no_of_tons'.tr(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: totalCOntroller,
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
                  if(selectedStreet!=null&&selectedBlock!=null&& numTankers!=null&& status!=null){

                    await asphaltWorkViewModel.addAsphalt(AsphaltWorkModel(
                      id: asphaltId,
                      block_no: selectedBlock,
                      street_no: selectedStreet,
                      no_of_tons: numTankers,
                      back_filling_status: status,
                      date: _getFormattedDate(),
                      time: _getFormattedTime(),
                      user_id: userId
                    ));

                    await asphaltWorkViewModel.fetchAllAsphalt();
                    await asphaltWorkViewModel.postDataFromDatabaseToAPI();
                    // Clear fields after submission
                    setState(() {
                      containerData = createInitialContainerData();
                    });
                    _clearFields();

                    showSnackBarSuccessfully(context);}
                  else{
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
