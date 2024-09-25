import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/main_stage_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import 'package:intl/intl.dart';
import '../../../ReusableDesigns/filter_widget.dart';

class MainStageWorkSummary extends StatefulWidget {
  MainStageWorkSummary({super.key});

  @override
  State<MainStageWorkSummary> createState() => _MainStageWorkSummaryState();
}

class _MainStageWorkSummaryState extends State<MainStageWorkSummary> {
  final MainStageWorkViewModel mainStageWorkViewModel = Get.put(MainStageWorkViewModel());
  DateTime? _start_date;
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
        title: Text(
          'main_stage_work_summary'.tr(),
          style: const TextStyle(
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
              onFilter: (start_date, endDate, status) {
                setState(() {
                  _start_date = start_date;
                  _endDate = endDate;
                  _status = status;
                });
              },
            ),
            const SizedBox(height: 16),

            Obx(() {
              // Use Obx to rebuild when the data changes
              if (mainStageWorkViewModel.allStage.isEmpty) {
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
              final filteredData = mainStageWorkViewModel.allStage.where((entry) {
                // Filter by start date
                final start_dateMatch = _start_date == null ||
                    (entry.start_date != null && entry.start_date!.isAfter(_start_date!));

                // Filter by end date
                final endDateMatch = _endDate == null ||
                    (entry.expected_comp_date != null && entry.expected_comp_date!.isBefore(_endDate!));

                // Filter by status
                final statusMatch = _status == null ||
                    (entry.main_stage_work_comp_status != null &&
                        entry.main_stage_work_comp_status!.toLowerCase().contains(_status!.toLowerCase()));

                return start_dateMatch && endDateMatch && statusMatch;
              }).toList();

              // Show "No data available" if the list is empty
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
                    DataColumn(label: Text('start_date'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('end_date'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('status'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('date'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('time'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: filteredData.map((entry) {
                    // Format the DateTime objects to a readable string format
                    String start_date = entry.start_date != null
                        ? DateFormat('d MMM yyyy').format(entry.start_date!)
                        : ''; // Show empty string if null

                    String expected_comp_date = entry.expected_comp_date != null
                        ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                        : ''; // Show empty string if null

                    return DataRow(cells: [
                      DataCell(Text(start_date)), // Formatted start date
                      DataCell(Text(expected_comp_date)), // Formatted expected completion date
                      DataCell(Text(entry.main_stage_work_comp_status ?? '')), // Null check for status
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
