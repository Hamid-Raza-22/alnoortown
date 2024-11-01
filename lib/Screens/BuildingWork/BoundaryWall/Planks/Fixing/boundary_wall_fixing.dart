import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Screens/BuildingWork/BoundaryWall/Planks/Fixing/planks_fixing_summasry.dart';
import 'package:al_noor_town/ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/BoundaryWallViewModel/PlanksViewModel/planks_fixing_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/TownMainGatesModel/mg_plaster_work_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/TownMainGatesViewModel/mg_plaster_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import 'package:intl/intl.dart';

import '../../../../../Models/BuildingWorkModels/BoundarywallModel/PlanksModel/planks_fixing_model.dart';
import '../../../../../ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import '../../../../../Widgets/container_data.dart';
import '../../../../../Widgets/custom_text_feild.dart';
import '../../../../../Widgets/snackbar.dart';
import '../../../TownMainGate/Main Gate Plaster/MainGatePlasterSummary.dart';


class PlanksFixing extends StatefulWidget {
  PlanksFixing({super.key});

  @override
  PlanksFixingState createState() => PlanksFixingState();
}

class PlanksFixingState extends State<PlanksFixing> {
PlanksFixingViewModel planksFixingViewModel = Get.put(PlanksFixingViewModel());
  BlockDetailsViewModel blockDetailsViewModel = Get.put(BlockDetailsViewModel());

  String? selectedBlock;
  String? No_of_Planks;
  String? Total_length;
  String? work_status;

  @override

  TextEditingController noOfPillarsController=TextEditingController();
TextEditingController totalLengthController=TextEditingController();
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
    No_of_Planks=null; // Clear the controller's text
    Total_length=null;
    totalLengthController.clear();
    noOfPillarsController.clear();
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
                  builder: (context) => PlanksFixingSummary(),
                ),
              );
            },
          ),
        ],
        title:   Text(
          'Planks Fixing Page'.tr(),
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
            buildBlockRow((value) {
              setState(() {
                selectedBlock = value;
              });
            }),
            SizedBox(height: 16),
            buildWorkStatusField(
              'No. of Planks Fixing'.tr(),
              noOfPillarsController,
                  (value) {
                setState(() {
                  No_of_Planks = value;
                });
              },
            ),

            SizedBox(height: 16),
            buildWorkStatusField(
              'Total Length'.tr(),
              totalLengthController,
                  (value) {
                setState(() {
                  Total_length = value;
                });
              },
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  selectedBlock= containerData["selectedBlock"];

                  if (selectedBlock != null && No_of_Planks!= null && Total_length!=null) {
                    await planksFixingViewModel.addPillarsFixing(PlanksFixingModel(
                        block: selectedBlock,
                        no_of_planks: No_of_Planks,
                        total_length: Total_length,
                        date: _getFormattedDate(),
                        time: _getFormattedTime(),
                        user_id: userId

                    ));

                    await planksFixingViewModel.fetchAllPlanksFixing();
                    await planksFixingViewModel.postDataFromDatabaseToAPI();

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
                child:   Text('submit'.tr(),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBlockRow(ValueChanged<String?> onChanged) {
    final List<String> blocks = blockDetailsViewModel.allBlockDetails
        .map((blockDetail) => blockDetail.block.toString())
        .toSet()
        .toList();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('block_no'.tr(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC69840))),
          SizedBox(height: 8),

          DropdownSearch<String>(
            items: blocks,
            onChanged: onChanged,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFC69840)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
            ),
          )
        ]
    );
  }


}

