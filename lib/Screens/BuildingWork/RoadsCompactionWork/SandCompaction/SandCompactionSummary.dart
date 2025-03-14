import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/sand_compaction_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;

import '../../../ReusableDesigns/filter_widget.dart';

class SandCompactionSummary extends StatefulWidget {
  SandCompactionSummary({super.key});

  @override
  State<SandCompactionSummary> createState() => _SandCompactionSummaryState();
}

class _SandCompactionSummaryState extends State<SandCompactionSummary> {
  final SandCompactionViewModel sandCompactionViewModel = Get.put(SandCompactionViewModel());
  String? _block_no;
  String? _road_no;
  String? _status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Text(
          'sand_compaction_summary',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add the FilterWidget here
            FilterWidget(
              onFilter: (block_no, road_no, status) {
                setState(() {
                  _block_no = block_no as String?;
                  _road_no = road_no as String?;
                  _status = status;
                });
              },
            ),
             SizedBox(height: 16),

            Obx(() {
              // Use Obx to rebuild when the data changes
              if (sandCompactionViewModel.allSand.isEmpty) {
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Filter the data
              final filteredData = sandCompactionViewModel.allSand.where((entry) {
                final block_noMatch = _block_no == null || entry.block_no.contains(_block_no!);
                final road_noMatch = _road_no == null || entry.road_no.contains(_road_no!);
                final statusMatch = _status == null || entry.sand_comp_status.toLowerCase().contains(_status!.toLowerCase());

                return block_noMatch && road_noMatch && statusMatch;
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
                       SizedBox(height: 16),
                       Text(
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
                child:SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                child: DataTable(
                  columnSpacing: 12.0,
                  headingRowColor: WidgetStateProperty.all( Color(0xFFC69840)),
                  border:  TableBorder(
                    horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                    verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                  ),
                  columns: [
                    DataColumn(label: Text('block_no'.tr(), style:  TextStyle(fontWeight: FontWeight.bold))),
                     DataColumn(label: Text('road_no'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                     DataColumn(label: Text('total_length'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                     DataColumn(label: Text('Working Hours'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                     DataColumn(label: Text('start_date'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                     DataColumn(label: Text('end_date'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                     DataColumn(label: Text('status'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                     DataColumn(label: Text('date'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                     DataColumn(label: Text('time'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: filteredData.map((entry) {
                    String start_date = entry.start_date != null
                        ? DateFormat('d MMM yyyy').format(entry.start_date!)
                        : ''; // Show empty string if null
                    String expected_comp_date = entry.expected_comp_date != null
                        ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                        : '';

                    return DataRow(cells: [
                      DataCell(Text(entry.block_no ?? 'N/A')), // Provide a default value if block_no is null
                      DataCell(Text(entry.road_no ?? 'N/A')),
                      DataCell(Text(entry.total_length ?? 'N/A')),
                      DataCell(Text(entry.working_hours ?? 'N/A')),
                      DataCell(Text(start_date.isNotEmpty ? start_date : 'N/A')),
                      DataCell(Text(expected_comp_date.isNotEmpty ? expected_comp_date : 'N/A')),
                      DataCell(Text(entry.sand_comp_status ?? 'N/A')),
                      DataCell(Text(entry.date ?? 'N/A')),
                      DataCell(Text(entry.time ?? 'N/A')),
                    ]);

                  }).toList(),
                ),)
              );
            }),
          ],
        ),
      ),
    );
  }
}
