import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/mini_park_curb_stone_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../ReusableDesigns/filter_widget.dart';

class MiniParkCurbstonesSummary extends StatefulWidget {
  MiniParkCurbstonesSummary({super.key});

  @override
  State<MiniParkCurbstonesSummary> createState() => _MiniParkCurbstonesSummaryState();
}

class _MiniParkCurbstonesSummaryState extends State<MiniParkCurbstonesSummary> {
  final MiniParkCurbStoneViewModel miniParkCurbStoneViewModel = Get.put(MiniParkCurbStoneViewModel());

  DateTime? _startDate;
  DateTime? _endDate;
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
          'curbstones_work_summary',
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
              onFilter: (startDate, endDate, status) {
                setState(() {
                  _startDate = startDate;
                  _endDate = endDate;
                  _status = status;
                });
              },
            ),
            const SizedBox(height: 16),

            Obx(() {
              if (miniParkCurbStoneViewModel.allMpCurb.isEmpty) {
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
              final filteredData = miniParkCurbStoneViewModel.allMpCurb.where((entry) {
                // Filter by start date
                final startDateMatch = _startDate == null ||
                    (entry.startDate != null && entry.startDate!.isAfter(_startDate!));

                // Filter by end date
                final endDateMatch = _endDate == null ||
                    (entry.expectedCompDate != null && entry.expectedCompDate!.isBefore(_endDate!));

                // Filter by status
                final statusMatch = _status == null ||
                    (entry.mpCurbStoneCompStatus != null &&
                        entry.mpCurbStoneCompStatus!.toLowerCase().contains(_status!.toLowerCase()));

                return startDateMatch && endDateMatch && statusMatch;
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
                  columnSpacing: 16.0,
                  headingRowColor: MaterialStateProperty.all(const Color(0xFFC69840)),
                  border: const TableBorder(
                    horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                    verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                  ),
                  columns: [
                    const DataColumn(label: Text('start_date', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('end_date', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('status', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('date', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('time', style: TextStyle(fontWeight: FontWeight.bold))),
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
                      DataCell(Text(startDate)), // Formatted start date
                      DataCell(Text(expectedCompDate)), // Formatted expected completion date
                      DataCell(Text(entry.mpCurbStoneCompStatus ?? '')), // Null check for status
                      DataCell(Text(entry.date ?? '')), // Display date as-is
                      DataCell(Text(entry.time ?? '')), // Display time as-is
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
