
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/compaction_water_bound_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' show  Get, Inst, Obx;

class WaterBoundSummary extends StatefulWidget {
    WaterBoundSummary({super.key});

  @override
  State<WaterBoundSummary> createState() => _WaterBoundSummaryState();
}

class _WaterBoundSummaryState extends State<WaterBoundSummary> {
  final CompactionWaterBoundViewModel compactionWaterBoundViewModel = Get.put(CompactionWaterBoundViewModel());

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
          'compaction_after_water_bound_summary'.tr(),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:   EdgeInsets.all(12.0),
          child: Obx(() {
            // Use Obx to rebuild when the data changes
            if (compactionWaterBoundViewModel.allWaterBound.isEmpty) {
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
                rows: compactionWaterBoundViewModel.allWaterBound.map((entry) {
                  // Format the DateTime objects to a readable string format
                  String start_date = entry.start_date != null
                      ? DateFormat('d MMM yyyy').format(entry.start_date!)
                      : ''; // Show empty string if null

                  String expected_comp_date = entry.expected_comp_date != null
                      ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                      : ''; // Show empty string if null
                  return DataRow(cells: [
                    // Formatted start date

                    DataCell(Text(entry.block_no ?? '')),
                    // Null check for status
                    DataCell(Text(entry.road_no ?? '')),
                    DataCell(Text(entry.total_length ?? '')),
                    DataCell(Text(start_date)),
                    DataCell(Text(expected_comp_date)),
                    DataCell(Text(entry.water_bound_comp_status ?? '')),
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