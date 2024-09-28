import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/mp_plantation_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../ReusableDesigns/DateFilter.dart';

class Plantation_Mini_Summary extends StatefulWidget {
  Plantation_Mini_Summary({super.key});

  @override
  State<Plantation_Mini_Summary> createState() => _Plantation_Mini_SummaryState();
}

class _Plantation_Mini_SummaryState extends State<Plantation_Mini_Summary> {
  final MpPlantationWorkViewModel mpPlantationWorkViewModel = Get.put(MpPlantationWorkViewModel());
  List filteredData = [];

  @override
  void initState() {
    super.initState();
    // Initially, set the filteredData to all data
    filteredData = mpPlantationWorkViewModel.allMpPlant;
  }

  void filterData(DateTime? fromDate, DateTime? toDate) {
    if (fromDate == null && toDate == null) {
      // If no date is selected, show all data
      filteredData = mpPlantationWorkViewModel.allMpPlant;
    } else {
      // Filter data based on selected date range
      filteredData = mpPlantationWorkViewModel.allMpPlant.where((entry) {
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
        title: Text(
          'plantation_work_summary'.tr,
          style: const TextStyle(
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
              if (mpPlantationWorkViewModel.allMpPlant.isEmpty) {
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
                  headingRowColor: MaterialStateProperty.all(const Color(0xFFC69840)),
                  border: const TableBorder(
                    horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                    verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                  ),
                  columns: [
                    DataColumn(label: Text('start_date'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('end_date'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('status'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('date'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('time'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: filteredData.map((entry) {
                    String start_date = entry.start_date != null
                        ? DateFormat('d MMM yyyy').format(entry.start_date!)
                        : '';

                    String expected_comp_date = entry.expected_comp_date != null
                        ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                        : ''; // Show empty string if null

                    return DataRow(cells: [
                      DataCell(Text(start_date)),
                      DataCell(Text(expected_comp_date)),
                      DataCell(Text(entry.mini_park_plantation_comp_status ?? '')),
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
