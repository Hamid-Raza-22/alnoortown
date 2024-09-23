
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/soil_compaction_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' show  Get, Inst, Obx;

class SoilCompactionSummary extends StatefulWidget {

    SoilCompactionSummary({super.key});
  @override
  State<SoilCompactionSummary> createState() => _SoilCompactionSummaryState();
}

class _SoilCompactionSummaryState extends State<SoilCompactionSummary> {
  SoilCompactionViewModel soilCompactionViewModel = Get.put(SoilCompactionViewModel());
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
          'soil_compaction_summary'.tr(),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:   EdgeInsets.all(12.0),
          child: Obx(() {
            // Use Obx to rebuild when the data changes
            if (soilCompactionViewModel.allSoil.isEmpty) {
              return Center(
                  child: CircularProgressIndicator()); // Show loading indicator
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 12.0,
                headingRowColor: MaterialStateProperty.all(Color(0xFFC69840)),
                border: TableBorder(
                  horizontalInside: BorderSide(
                      color: Color(0xFFC69840), width: 1.0),
                  verticalInside: BorderSide(
                      color: Color(0xFFC69840), width: 1.0),
                ),
                columns: [
                  DataColumn(label: Text('block_no'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('road_no'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('total_length'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('start_date'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('end_date'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('status'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('date'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('time'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: soilCompactionViewModel.allSoil.map((entry) {
                  // Format the DateTime objects to a readable string format
                  String startDate = entry.startDate != null
                      ? DateFormat('d MMM yyyy').format(entry.startDate!)
                      : ''; // Show empty string if null

                  String expectedCompDate = entry.expectedCompDate != null
                      ? DateFormat('d MMM yyyy').format(entry.expectedCompDate!)
                      : ''; // Show empty string if null
                  return DataRow(cells: [
                    DataCell(Text(entry.block_no ?? '')),
                    DataCell(Text(entry.roadNo ?? '')),
                    DataCell(Text(entry.totalLength ?? '')),
                    DataCell(Text(startDate)),
                    DataCell(Text(expectedCompDate)),
                    DataCell(Text(entry.soilCompStatus ?? '')),
                    DataCell(Text(entry.date ?? '')),
                    DataCell(Text(entry.time ?? '')),
                  ]);
                }).toList(),
              ),
            );
          } ),
      ),
    );
  }
}