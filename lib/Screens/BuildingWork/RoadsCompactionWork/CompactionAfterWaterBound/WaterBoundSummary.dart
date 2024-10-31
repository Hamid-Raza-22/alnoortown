import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/compaction_water_bound_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/compaction_water_bound_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' show Get, Inst, Obx;

import '../../../ReusableDesigns/filter_widget.dart';

class WaterBoundSummary extends StatefulWidget {
  WaterBoundSummary({super.key});

  @override
  State<WaterBoundSummary> createState() => _WaterBoundSummaryState();
}

class _WaterBoundSummaryState extends State<WaterBoundSummary> {
  final CompactionWaterBoundViewModel compactionWaterBoundViewModel = Get.put(CompactionWaterBoundViewModel());

  DateTime? fromDate;
  DateTime? toDate;
  String? block;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'compaction_after_water_bound_summary'.tr(),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            // FilterWidget call
            FilterWidget(
              onFilter: (DateTime? fromDate, DateTime? toDate, String? block) {
                setState(() {
                  this.fromDate = fromDate;
                  this.toDate = toDate;
                  this.block = block;
                });
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                // Use Obx to rebuild when the data changes
                List<CompactionWaterBoundModel> filteredData = compactionWaterBoundViewModel.allWaterBound;

                if (fromDate != null) {
                  filteredData = filteredData
                      .where((entry) =>
                  entry.start_date != null &&
                      entry.start_date!.isAfter(fromDate!))
                      .toList();
                }

                if (toDate != null) {
                  filteredData = filteredData
                      .where((entry) =>
                  entry.expected_comp_date != null &&
                      entry.expected_comp_date!.isBefore(toDate!))
                      .toList();
                }

                if (block != null && block!.isNotEmpty) {
                  filteredData = filteredData
                      .where((entry) =>
                  entry.block_no != null &&
                      entry.block_no!.contains(block!))
                      .toList();
                }

                if (filteredData.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/nodata.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No data available',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
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
                      DataColumn(
                          label: Text('block_no'.tr(),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('road_no'.tr(),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('total_length'.tr(),
                              style: TextStyle(fontWeight: FontWeight.bold))),                      DataColumn(
                          label: Text('Working Hours'.tr(),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('start_date'.tr(),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('end_date'.tr(),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('status'.tr(),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('date'.tr(),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('time'.tr(),
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: filteredData.map((entry) {
                      // Format the DateTime objects to a readable string format
                      String start_date = entry.start_date != null
                          ? DateFormat('d MMM yyyy').format(entry.start_date!)
                          : ''; // Show empty string if null

                      String expected_comp_date = entry.expected_comp_date != null
                          ? DateFormat('d MMM yyyy')
                          .format(entry.expected_comp_date!)
                          : ''; // Show empty string if null
                      return DataRow(cells: [
                        DataCell(Text(entry.block_no ?? '')),
                        DataCell(Text(entry.road_no ?? '')),
                        DataCell(Text(entry.total_length ?? '')),
                        DataCell(Text(entry.working_hours ?? '')),
                        DataCell(Text(start_date)),
                        DataCell(Text(expected_comp_date)),
                        DataCell(Text(entry.water_bound_comp_status ?? '')),
                        DataCell(Text(entry.date ?? '')),
                        DataCell(Text(entry.time ?? '')),
                      ]);
                    }).toList(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
