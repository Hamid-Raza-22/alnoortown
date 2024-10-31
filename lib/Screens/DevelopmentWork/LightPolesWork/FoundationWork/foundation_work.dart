import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_excavation_model.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/LightPolesWork/FoundationWork/foundation_work_summary.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/LightPolesWork/PolesExcavation/poles_excavation_summary.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/LightPolesWorkViewModel/poles_excavation_view_model.dart';
import 'package:al_noor_town/Widgets/snackbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import '../../../../Models/DevelopmentsWorksModels/LightPolesWorkModels/poles_foundation_model.dart';
import '../../../../ViewModels/DevelopmentWorksViewModel/LightPolesWorkViewModel/poles_foundation_view_model.dart';
import '../../../../ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import '../../../../Widgets/custom_dropdown_widgets.dart';

class Foundation extends StatefulWidget {
  Foundation({super.key});

  @override
  PolesFoundationState createState() => PolesFoundationState();
}

class PolesFoundationState extends State<Foundation> {
  PolesFoundationViewModel polesFoundationViewModel = Get.put(PolesFoundationViewModel());
  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());
  DBHelper dbHelper = DBHelper();
  int? exId;

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
      "polesFoundation":null,
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
  void dispose() {
    totalCOntroller.dispose(); // Dispose controller to free resources
    super.dispose();
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
                    builder: (context) =>FoundationWorkSummary(),
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
                  'Poles Foundation Work'.tr(),
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
              "No. of Poles Foundation".tr(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            SizedBox(height: 8),
            TextFormField(
             controller: totalCOntroller,
              onChanged: (value) {
                setState(() {
                  containerData["polesFoundation"] = value;
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
                  final polesFoundation = containerData["polesFoundation"];
                  if(selectedStreet!=null&&selectedBlock!=null&& polesFoundation!=null){
                  await polesFoundationViewModel.addPoleFoundation(PolesFoundationModel(
                      id: exId,
                      block_no: selectedBlock,
                      street_no: selectedStreet,
                      no_of_foundation: polesFoundation,
                      date: _getFormattedDate(),
                      time: _getFormattedTime(),
                      user_id: userId
                  ));
                  await polesFoundationViewModel.fetchAllPoleFoundation();
                  polesFoundationViewModel.postDataFromDatabaseToAPI();

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
}
