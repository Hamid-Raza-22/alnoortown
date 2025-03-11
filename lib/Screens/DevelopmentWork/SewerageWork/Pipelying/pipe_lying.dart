import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/SewerageWorksModels/pipeline_model.dart';
import 'package:al_noor_town/Screens/DevelopmentWork/SewerageWork/Pipelying/pipelying_summary.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/SewerageWorksViewModel/pipeline_view_model.dart';
import 'package:al_noor_town/Widgets/snackbar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import '../../../../ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import '../../../../ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import '../../../../Widgets/custom_dropdown_widgets.dart';

class Pipelying extends StatefulWidget {
  Pipelying({super.key});

  @override
  _PipelyingState createState() => _PipelyingState();
}

class _PipelyingState extends State<Pipelying> {

  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());
  PipelineViewModel pipelineViewModel=Get.put(PipelineViewModel());
  TextEditingController numTankersController =TextEditingController();
  DBHelper dbHelper = DBHelper();
  int? pipeId;
Map<String, dynamic> containerData = {};
  @override
  void initState() {
    super.initState();
    containerData = createInitialContainerData();

  }
  void _clearFields() {
    setState(() {
      containerData = createInitialContainerData();
      numTankersController.clear();
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

  Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedBlock": null,
      "selectedStreet": null,
      "numTankers": '',
    };
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
                    image: AssetImage('assets/images/pipelines.png'),
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
                    builder: (context) => PipelyingSummary(),
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
                  'pipe_laying'.tr(),
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
              ),
            ),
            buildContainer(),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final selectedBlock = containerData["selectedBlock"];
                  final selectedStreet = containerData["selectedStreet"];
                   String numTankers = containerData["numTankers"];
                  if(selectedStreet!=null&&selectedBlock!=null&& numTankersController.text.isNotEmpty&& numTankers!=null){

                  await pipelineViewModel.addPipe(PipelineModel(
                      id: pipeId,
                      block_no: selectedBlock,
                      street_no: selectedStreet,
                      length: numTankers,
                      date: _getFormattedDate(),
                      time: _getFormattedTime(),
                    user_id: userId
                  ));
                  await pipelineViewModel.fetchAllPipe();
                  await pipelineViewModel.postDataFromDatabaseToAPI();

                  // await dbHelper.showAsphaltData();

                  showSnackBarSuccessfully(context);

               _clearFields();
                  }
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
              'total_length_completed'.tr(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
            ),
            SizedBox(height: 8),
            TextFormField(
               controller: numTankersController,
              onChanged: (value) {
                setState(() {
                  containerData["numTankers"] = value;
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    numTankersController.dispose(); // Dispose controller to free resources
    super.dispose();
  }


}
