import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/monuments_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../ReusableDesigns/DateFilter.dart';

class MonumentsWorkSummary extends StatefulWidget {
  MonumentsWorkSummary({super.key});

  @override
  State<MonumentsWorkSummary> createState() => _MonumentsWorkSummaryState();
}

class _MonumentsWorkSummaryState extends State<MonumentsWorkSummary> {
  MonumentsWorkViewModel monumentsWorkViewModel = Get.put(MonumentsWorkViewModel());
  List filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = monumentsWorkViewModel.allMonument;
  }

  void filterData(DateTime? fromDate, DateTime? toDate) {
    if (fromDate == null && toDate == null) {
      filteredData = monumentsWorkViewModel.allMonument;
    } else {
      filteredData = monumentsWorkViewModel.allMonument.where((entry) {
        DateTime entryDate = entry.start_date ?? DateTime.now();
        if (fromDate != null && toDate != null) {
          return entryDate.isAfter(fromDate.subtract(const Duration(days: 1))) &&
              entryDate.isBefore(toDate.add(const Duration(days: 1)));
        } else if (fromDate != null) {
          return entryDate.isAfter(fromDate.subtract(const Duration(days: 1)));
        } else if (toDate != null) {
          return entryDate.isBefore(toDate.add(const Duration(days: 1)));
        }
        return false;
      }).toList();
    }
    setState(() {});
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
        title: const Text(
          'monuments_work_summary',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchByDate(
              onFilter: filterData,
            ),
            const SizedBox(height: 10),
            Obx(() {
              if (monumentsWorkViewModel.allMonument.isEmpty) {
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

              if (filteredData.isEmpty) {
                return const Center(child: Text('No results found'));
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 16.0,
                  headingRowColor: WidgetStateProperty.all(const Color(0xFFC69840)),
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
                        : '';

                    return DataRow(cells: [
                      DataCell(Text(start_date)),
                      DataCell(Text(expected_comp_date)),
                      DataCell(Text(entry.monuments_work_comp_status ?? '')),
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
