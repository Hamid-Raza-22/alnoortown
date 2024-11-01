import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/main_gate_pillar_work_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/TownMainGatesViewModel/main_gate_pillar_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import 'package:intl/intl.dart';
import '../../../../ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import '../../../../Widgets/buildBlockRow.dart';
import '../../../../Widgets/container_data.dart';
import '../../../../Widgets/snackbar.dart';
import 'MainGatePillarsBrickSummary.dart';

class MainGatePillarsBrickWork extends StatefulWidget {
    MainGatePillarsBrickWork({super.key});

  @override
  _MainGatePillarsBrickWorkState createState() => _MainGatePillarsBrickWorkState();
}

class _MainGatePillarsBrickWorkState extends State<MainGatePillarsBrickWork> {
  MainGatePillarWorkViewModel mainGatePillarWorkViewModel=Get.put(MainGatePillarWorkViewModel());
  BlockDetailsViewModel blockDetailsViewModel = Get.put(BlockDetailsViewModel());
  TextEditingController workStatusController=TextEditingController();

  String? selectedBlock;
  String? work_status;

  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());

  void initState() {
    super.initState();
    containerData = createInitialContainerData();
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedBlock": null,
      "selectedStreet":null
    };
  }
  void _clearFields() {
    setState(() {
      containerData = createInitialContainerData();
      work_status=null; // Clear the controller's text
      workStatusController.clear();
    });
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:   Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon:   Icon(Icons.history_edu_outlined, color: Color(0xFFC69840)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MainGatePillarsBrickSummary(),
                ),
              );
            },
          ),
        ],
        title:   Text(
          'main_gate_pillars_brick'.tr(),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/gateeee-01.png',
              fit: BoxFit.cover,
              height: 170.0,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding:   EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildContainer(),
                    SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer() {
    return Card(
      margin:   EdgeInsets.only(bottom: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding:   EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockColumn(containerData, roadDetailsViewModel, blockDetailsViewModel),

            SizedBox(height: 16),
            buildWorkStatusField(workStatusController),
              SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  selectedBlock= containerData["selectedBlock"];

                  if (selectedBlock != null && work_status != null) {
                    await mainGatePillarWorkViewModel.addMainPillar(MainGatePillarWorkModel(
                      block_no: selectedBlock,
                      work_status: work_status,
                        date: _getFormattedDate(),
                        time: _getFormattedTime(),
                      user_id: userId
                      // date:
                    ));

                    await mainGatePillarWorkViewModel.fetchAllMainPillar();
                    await mainGatePillarWorkViewModel.postDataFromDatabaseToAPI();


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
                  backgroundColor:   Color(0xFFF3F4F6),
                  padding:   EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle:   TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child:   Text('submit'.tr().tr(),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWorkStatusField(TextEditingController contoller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('work_status'.tr(),
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
        SizedBox(height: 8),
        TextField(
          controller: workStatusController,
          onChanged: (value) {

            setState(() {
              work_status = value;
            });
          },
          maxLines: 3,
          decoration:   InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFC69840))),
            contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          ),
        ),
      ],
    );
  }
}

