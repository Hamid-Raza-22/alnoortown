import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/sitting_area_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../ReusableDesigns/filter_widget.dart';

class SittingAreaSummaryPage extends StatelessWidget {
  final SittingAreaWorkViewModel sittingAreaWorkViewModel = Get.put(SittingAreaWorkViewModel());

  SittingAreaSummaryPage({super.key});

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
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0), // Consistent padding with Mudfilling
        child: Column(
          children: [
            // Integrate the FilterWidget
            FilterWidget(
              onFilter: (fromDate, toDate, block) {
                // Call a method to apply the filter
                sittingAreaWorkViewModel.applyFilters(fromDate, toDate, block);
              },
            ),
            const SizedBox(height: 12),
            Obx(() {
              // Use Obx to rebuild when the data changes
              if (sittingAreaWorkViewModel.allSitting.isEmpty) {
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
                    DataColumn(
                      label: Text('type_of_work'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                    DataColumn(
                      label: Text('start_date'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                    DataColumn(
                      label: Text('end_date'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                    DataColumn(
                      label: Text('status'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                    DataColumn(
                      label: Text('date'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                    DataColumn(
                      label: Text('time'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ],
                  rows: sittingAreaWorkViewModel.allSitting.map((entry) {
                    String start_date = entry.start_date != null
                        ? DateFormat('d MMM yyyy').format(entry.start_date!)
                        : '';

                    String expected_comp_date = entry.expected_comp_date != null
                        ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                        : '';

                    return DataRow(cells: [
                      DataCell(Text(entry.type_of_work ?? '')),
                      DataCell(Text(start_date)),
                      DataCell(Text(expected_comp_date)),
                      DataCell(Text(entry.sitting_area_comp_status ?? '')),
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
