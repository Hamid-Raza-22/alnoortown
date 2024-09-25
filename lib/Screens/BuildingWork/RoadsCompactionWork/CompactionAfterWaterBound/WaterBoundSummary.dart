import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/compaction_water_bound_view_model.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' show Get, Inst, Obx;

import '../../../../Models/BuildingWorkModels/RoadsCompactionWork/compaction_water_bound_model.dart';
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
  String? selectedBlock;

  List<CompactionWaterBoundModel> getFilteredData() {
    return compactionWaterBoundViewModel.allWaterBound.where((entry) {
      bool matchesDateRange = true;
      bool matchesBlock = true;

      if (fromDate != null && toDate != null) {
        matchesDateRange = entry.startDate != null &&
            entry.expectedCompDate != null &&
            entry.startDate!.isAfter(fromDate!) &&
            entry.expectedCompDate!.isBefore(toDate!);
      }

      if (selectedBlock != null && selectedBlock!.isNotEmpty) {
        matchesBlock = entry.block_no == selectedBlock;
      }

      return matchesDateRange && matchesBlock;
    }).toList();
  }

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
            // Add FilterWidget above the grid
            FilterWidget(
              onFilter: (DateTime? from, DateTime? to, String? block) {
                setState(() {
                  fromDate = from;
                  toDate = to;
                  selectedBlock = block;
                });
              },
            ),
            Expanded(
              child: Obx(() {
                // Use Obx to rebuild when the data changes
                List<CompactionWaterBoundModel> filteredData = getFilteredData();

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
                        const SizedBox(height: 16),
                        const Text(
                          'No data available',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
                      horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                      verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                    ),
                    columns: [
                      DataColumn(label: Text('block_no'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('road_no'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('total_length'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('start_date'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('end_date'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('status'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('date'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('time'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: filteredData.map((entry) {
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
                        DataCell(Text(entry.waterBoundCompStatus ?? '')),
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
