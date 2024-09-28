import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/grass_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../ReusableDesigns/DateFilter.dart';

class GrassWorkSummary extends StatefulWidget {
  GrassWorkSummary({super.key});

  @override
  State<GrassWorkSummary> createState() => _GrassWorkSummaryState();
}

class _GrassWorkSummaryState extends State<GrassWorkSummary> {
  final GrassWorkViewModel grassWorkViewModel = Get.put(GrassWorkViewModel());

  void _filterByDate(DateTime? fromDate, DateTime? toDate) {
    grassWorkViewModel.filterGrassWork(fromDate, toDate);
  }

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
          'gras_work_summary'.tr,
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
            // Add the SearchByDate widget here
            SearchByDate(
              onFilter: _filterByDate, // Pass the filter callback
            ),
            Expanded(
              child: Obx(() {
                // Use filteredGrass instead of allGrass
                if (grassWorkViewModel.filteredGrass.isEmpty) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  ); // Show loading indicator
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 16.0,
                    headingRowColor: MaterialStateProperty.all(const Color(0xFFC69840)),
                    border: const TableBorder(
                      horizontalInside: BorderSide(
                        color: Color(0xFFC69840),
                        width: 1.0,
                      ),
                      verticalInside: BorderSide(
                        color: Color(0xFFC69840),
                        width: 1.0,
                      ),
                    ),
                    columns: [
                      DataColumn(
                        label: Text(
                          'start_date'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'end_date'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'status'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'date'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'time'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: grassWorkViewModel.filteredGrass.map((entry) {
                      // Format the DateTime objects to a readable string format
                      String start_date = entry.start_date != null
                          ? DateFormat('d MMM yyyy').format(entry.start_date!)
                          : ''; // Show empty string if null

                      String expected_comp_date = entry.expected_comp_date != null
                          ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                          : ''; // Show empty string if null
                      return DataRow(
                        cells: [
                          DataCell(Text(start_date)), // Formatted start date
                          DataCell(Text(expected_comp_date)), // Formatted expected completion date
                          DataCell(Text(entry.grass_work_comp_status ?? '')), // Null check for status
                          DataCell(Text(entry.date ?? '')), // Display date as-is (assuming it's already formatted)
                          DataCell(Text(entry.time ?? '')), // Display time as-is (assuming it's already formatted)
                        ],
                      );
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
