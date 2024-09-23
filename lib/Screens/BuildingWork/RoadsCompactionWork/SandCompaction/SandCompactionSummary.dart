import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/sand_compaction_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../ReusableDesigns/filter_widget.dart';

class SandCompactionSummary extends StatefulWidget {
  SandCompactionSummary({super.key});

  @override
  State<SandCompactionSummary> createState() => _SandCompactionSummaryState();
}

class _SandCompactionSummaryState extends State<SandCompactionSummary> {
  final SandCompactionViewModel sandCompactionViewModel = Get.put(SandCompactionViewModel());
  String? _blockNo;
  String? _roadNo;
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add the FilterWidget here
            FilterWidget(
              onFilter: (blockNo, roadNo, status) {
                setState(() {
                  _blockNo = blockNo as String?;
                  _roadNo = roadNo as String?;
                  _status = status;
                });
              },
            ),
            const SizedBox(height: 16),

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
              final filteredData = sandCompactionViewModel.allSand.where((entry) {
                final blockNoMatch = _blockNo == null || entry.blockNo.contains(_blockNo!);
                final roadNoMatch = _roadNo == null || entry.roadNo.contains(_roadNo!);
                final statusMatch = _status == null || entry.sandCompStatus.toLowerCase().contains(_status!.toLowerCase());

                return blockNoMatch && roadNoMatch && statusMatch;
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
                  headingRowColor: WidgetStateProperty.all(const Color(0xFFC69840)),
                  border: const TableBorder(
                    horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                    verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                  ),
                  columns: [
                    const DataColumn(label: Text('block_no', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('road_no', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('total_length', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('start_date', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('end_date', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('status', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('date', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('time', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: filteredData.map((entry) {
                    String startDate = entry.startDate != null
                        ? DateFormat('d MMM yyyy').format(entry.startDate!)
                        : ''; // Show empty string if null
                    String expectedCompDate = entry.expectedCompDate != null
                        ? DateFormat('d MMM yyyy').format(entry.expectedCompDate!)
                        : '';

                    return DataRow(cells: [
                      DataCell(Text(entry.blockNo)),
                      DataCell(Text(entry.roadNo)),
                      DataCell(Text(entry.totalLength)),
                      DataCell(Text(startDate)),
                      DataCell(Text(expectedCompDate)),
                      DataCell(Text(entry.sandCompStatus)),
                      DataCell(Text(entry.date)),
                      DataCell(Text(entry.time)),
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
