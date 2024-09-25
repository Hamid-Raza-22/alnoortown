import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/sitting_area_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../ReusableDesigns/DateFilter.dart';

class SittingAreaSummaryPage extends StatelessWidget {
  final SittingAreaWorkViewModel sittingAreaWorkViewModel = Get.put(SittingAreaWorkViewModel());

  SittingAreaSummaryPage({super.key});

  DateTime? fromDate;
  DateTime? toDate;

  // Filter the data based on the selected date range
  List<dynamic> getFilteredData() {
    if (fromDate == null && toDate == null) {
      return sittingAreaWorkViewModel.allSitting;
    }

    return sittingAreaWorkViewModel.allSitting.where((entry) {
      DateTime entryDate = entry.startDate ?? DateTime.now(); // Adjust to your actual date field
      if (fromDate != null && entryDate.isBefore(fromDate!)) {
        return false;
      }
      if (toDate != null && entryDate.isAfter(toDate!)) {
        return false;
      }
      return true;
    }).toList();
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
          'sitting_area_work_summary'.tr,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date filter widget
            SearchByDate(
              onFilter: (from, to) {
                fromDate = from;
                toDate = to;
                (context as Element).markNeedsBuild();
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                List<dynamic> filteredData = getFilteredData();
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
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 16.0,
                      headingRowColor: WidgetStateProperty.all( Color(0xFFC69840)),
                      columns: [
                        DataColumn(
                          label: Text(
                            'type_of_work'.tr,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'start_date'.tr,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'end_date'.tr,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'status'.tr,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'date'.tr,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'time'.tr,
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
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
                          DataCell(Text(entry.typeOfWork ?? '')),
                          DataCell(Text(startDate)),
                          DataCell(Text(expectedCompDate)),
                          DataCell(Text(entry.sittingAreaCompStatus ?? '')),
                          DataCell(Text(entry.date ?? '')),
                          DataCell(Text(entry.time ?? '')),
                        ]);
                      }).toList(),
                    ),
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
