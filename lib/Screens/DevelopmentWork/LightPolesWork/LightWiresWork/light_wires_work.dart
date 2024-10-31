import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/light_wires_model.dart';
import 'package:al_noor_town/ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/LightPolesWorkViewModel/light_wires_view_model.dart';
import 'package:al_noor_town/ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import '../../../../Widgets/custom_dropdown_widgets.dart';
import '../../../../Widgets/snackbar.dart';
import 'light_wires_work_summary.dart';

class LightWiresWork extends StatefulWidget {
  LightWiresWork({super.key});

  @override
  LightWiresWorkState createState() => LightWiresWorkState();
}

class LightWiresWorkState extends State<LightWiresWork> {

  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());
  LightWiresViewModel lightWiresViewModel = Get.put(LightWiresViewModel());
  DBHelper dbHelper = DBHelper();
  int? wireId;
 Map<String, dynamic> containerData = {};
  TextEditingController totalCOntroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    containerData = createInitialContainerData();
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedBlock": null,
      "selectedStreet": null,
      "total_length": null,
      "status": null,
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
                    image: AssetImage('assets/images/lightwire-01.png'),
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
                    builder: (context) => LightWorkSummary(),
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
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'light_wires_work'.tr(),
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
            buildBlockStreetRow(containerData, roadDetailsViewModel),
            SizedBox(height: 16),
            Text(
              "total_length".tr(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            SizedBox(height: 8),
            TextFormField(
                 controller: totalCOntroller,
              onChanged: (value) {
              setState(() {
                containerData["total_length"] = value;
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
            SizedBox(height: 16),
            Text(
              'status'.tr(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            SizedBox(height: 8),
            buildStatusRadioButtons(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final selectedBlock = containerData["selectedBlock"];
                  final selectedStreet = containerData["selectedStreet"];
                  final total_length = containerData["total_length"];
                  final status = containerData["status"];
                  if (selectedStreet != null && selectedBlock != null &&
                      total_length != null && status != null) {
                    await lightWiresViewModel.addLight(LightWiresModel(
                        id: wireId,
                        block_no: selectedBlock,
                        street_no: selectedStreet,
                        total_length: total_length,
                        light_wire_work_status: status,
                        date: _getFormattedDate(),
                        time: _getFormattedTime(),
                        user_id: userId
                    ));
                    await lightWiresViewModel.fetchAllLight();
                    await lightWiresViewModel.postDataFromDatabaseToAPI();


                    // Clear fields after submission
                    setState(() {
                      containerData = createInitialContainerData();
                    });
                    _clearFields();

                    showSnackBarSuccessfully(context);
                  }
                  else {
                    showSnackBarPleaseFill(context);
                  }
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
          activeColor: Color(0xFFC69840),
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
          activeColor: Color(0xFFC69840),
        ),
      ],
    );
  }
}
