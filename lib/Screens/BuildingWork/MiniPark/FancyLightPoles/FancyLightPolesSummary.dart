import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/mp_fancy_light_poles_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../ReusableDesigns/filter_widget.dart';

class FancyLightPolesSummary extends StatefulWidget {
  FancyLightPolesSummary({super.key});

  @override
  State<FancyLightPolesSummary> createState() => _FancyLightPolesSummaryState();
}

class _FancyLightPolesSummaryState extends State<FancyLightPolesSummary> {
  final MpFancyLightPolesViewModel mpFancyLightPolesViewModel = Get.put(MpFancyLightPolesViewModel());
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
        title: const Text(
          'fancy_light_poles_summary',
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
              if (mpFancyLightPolesViewModel.allMpFancy.isEmpty) {
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

              final filteredData = mpFancyLightPolesViewModel.allMpFancy.where((entry) {
                // Filter by start date
                final start_dateMatch = _start_date == null ||
                    (entry.start_date != null && entry.start_date!.isAfter(_start_date!));

                // Filter by end date
                final endDateMatch = _endDate == null ||
                    (entry.expected_comp_date != null && entry.expected_comp_date!.isBefore(_endDate!));

                // Filter by status
                final statusMatch = _status == null ||
                    (entry.mini_park_fancy_light_comp_status != null &&
                        entry.mini_park_fancy_light_comp_status!.toLowerCase().contains(_status!.toLowerCase()));

                return start_dateMatch && endDateMatch && statusMatch;
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
                    String start_date = entry.start_date != null
                        ? DateFormat('d MMM yyyy').format(entry.start_date!)
                        : ''; // Show empty string if null

                    String expected_comp_date = entry.expected_comp_date != null
                        ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                        : ''; // Show empty string if null

                    return DataRow(cells: [
                      DataCell(Text(start_date)), // Formatted start date
                      DataCell(Text(expected_comp_date)), // Formatted expected completion date
                      DataCell(Text(entry.mini_park_fancy_light_comp_status ?? '')), // Null check for status
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
