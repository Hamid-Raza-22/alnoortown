import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsShouldersWorkViewModel/roads_shoulder_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../../ReusableDesigns/filter_widget.dart';


class RoadsShouldersSummary extends StatefulWidget {
  RoadsShouldersSummary({super.key});

  @override
  State<RoadsShouldersSummary> createState() => _RoadsShouldersSummaryState();
}

class _RoadsShouldersSummaryState extends State<RoadsShouldersSummary> {
  final RoadsShoulderWorkViewModel roadsShoulderWorkViewModel = Get.put(RoadsShoulderWorkViewModel());
  String? _block_no;
  String? _roadSide;
  String? _status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'roads_shoulders_summary',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Add the FilterWidget here
            FilterWidget(
              onFilter: (block_no, roadSide, status) {
                setState(() {
                  _block_no = block_no as String?;
                  _roadSide = roadSide as String?;
                  _status = status;
                });
              },
            ),
            const SizedBox(height: 16),

            Obx(() {
              // Use Obx to rebuild when the data changes
              if (roadsShoulderWorkViewModel.allRoadShoulder.isEmpty) {
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

              // Filter the data
              final filteredData = roadsShoulderWorkViewModel.allRoadShoulder.where((entry) {
                final block_noMatch = _block_no == null || (entry.block_no != null && entry.block_no!.contains(_block_no!));
                final roadSideMatch = _roadSide == null || (entry.roadSide != null && entry.roadSide!.contains(_roadSide!));
                final statusMatch = _status == null || (entry.roadsShoulderCompStatus != null && entry.roadsShoulderCompStatus!.toLowerCase().contains(_status!.toLowerCase()));

                return block_noMatch && roadSideMatch && statusMatch;
              }).toList();

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
                  headingRowColor: MaterialStateProperty.all(const Color(0xFFC69840)),
                  border: const TableBorder(
                    horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                    verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                  ),
                  columns: [
                    const DataColumn(label: Text('block_no', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('road_side', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('road_no', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('total_length', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('start_date', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('end_date', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('status', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('date', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('time', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: filteredData.map((entry) {
                    String startDate = entry.startDate != null ? DateFormat('d MMM yyyy').format(entry.startDate!) : '';
                    String expectedCompDate = entry.expectedCompDate != null ? DateFormat('d MMM yyyy').format(entry.expectedCompDate!) : '';

                    return DataRow(cells: [
                      DataCell(Text(entry.block_no ?? '')),
                      DataCell(Text(entry.roadSide ?? '')),
                      DataCell(Text(entry.roadNo ?? '')),
                      DataCell(Text(entry.totalLength ?? '')),
                      DataCell(Text(startDate)),
                      DataCell(Text(expectedCompDate)),
                      DataCell(Text(entry.roadsShoulderCompStatus ?? '')),
                      DataCell(Text(entry.date ?? '')),
                      DataCell(Text(entry.time ?? '')),
                    ]);
                  }).toList(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
