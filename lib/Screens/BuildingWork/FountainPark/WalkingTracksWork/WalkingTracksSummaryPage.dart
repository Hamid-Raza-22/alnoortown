import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/walking_tracks_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' show  Get, Inst, Obx;

class WalkingTracksSummaryPage extends StatefulWidget {
  WalkingTracksSummaryPage({super.key});
  @override
  State<WalkingTracksSummaryPage> createState() => _WalkingTracksSummaryPageState();
}
class _WalkingTracksSummaryPageState extends State<WalkingTracksSummaryPage> {
   WalkingTracksWorkViewModel walkingTracksWorkViewModel = Get.put(WalkingTracksWorkViewModel());
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
        title:   Text(
          'walking_tracks_work_summary'.tr(),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:   EdgeInsets.all(16.0),
          child: Obx(() {
            // Use Obx to rebuild when the data changes
            if (walkingTracksWorkViewModel.allWalking.isEmpty) {
              return Center(
                  child: CircularProgressIndicator()); // Show loading indicator
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                      label: Text("type_of_work".tr(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                  DataColumn(
                      label: Text('start_date'.tr(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                  DataColumn(
                      label: Text('end_date'.tr(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                  DataColumn(
                      label: Text('status'.tr(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                  DataColumn(
                      label: Text('date'.tr(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                  DataColumn(
                      label: Text('time'.tr(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                ],
                rows: walkingTracksWorkViewModel.allWalking.map((entry) {
                  // Format the DateTime objects to a readable string format
                  String startDate = entry.startDate != null
                      ? DateFormat('d MMM yyyy').format(entry.startDate!)
                      : ''; // Show empty string if null

                  String expectedCompDate = entry.expectedCompDate != null
                      ? DateFormat('d MMM yyyy').format(entry.expectedCompDate!)
                      : ''; // Show empty string if null
                  return DataRow(cells: [
                    // Formatted start date

                    DataCell(Text(entry.typeOfWork ?? '')),
                    DataCell(Text(startDate)),
                    DataCell(Text(expectedCompDate)),
                    DataCell(Text(entry.walkingTracksCompStatus ?? '')),
                    // Null check for status
                    DataCell(Text(entry.date ?? '')),
                    // Display date as-is (assuming it's already formatted)
                    DataCell(Text(entry.time ?? '')),
                    // Display time as-is (assuming it's already formatted)
                  ]);
                }).toList(),
              ),
            );
          }),
        ),
      );
  }
}