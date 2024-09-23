import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/sitting_area_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;

class SittingAreaSummaryPage extends StatelessWidget {
  SittingAreaWorkViewModel sittingAreaWorkViewModel = Get.put(SittingAreaWorkViewModel());
  SittingAreaSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:   const Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:   Text(
          'sitting_area_work_summary'.tr(),
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:   const EdgeInsets.all(16.0),
          child: Obx(() {
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
                columns: [
                  DataColumn(
                      label: Text('type_of_work'.tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                  DataColumn(
                      label: Text('start_date'.tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                  DataColumn(
                      label: Text('end_date'.tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                  DataColumn(
                      label: Text('status'.tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                  DataColumn(
                      label: Text('date'.tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                  DataColumn(
                      label: Text('time'.tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840)))),
                ],
                rows: sittingAreaWorkViewModel.allSitting.map((entry) {
                  // Format the DateTime objects to a readable string format
                  String startDate = entry.startDate != null
                      ? DateFormat('d MMM yyyy').format(entry.startDate!)
                      : ''; // Show empty string if null

                  String expectedCompDate = entry.expectedCompDate != null
                      ? DateFormat('d MMM yyyy').format(entry.expectedCompDate!)
                      : ''; // Show empty string if null
                  return DataRow(cells: [
                    // Formatted start date

                    DataCell(Text(entry.typeOfWork ?? '')),
                    DataCell(Text(startDate)),
                    DataCell(Text(expectedCompDate)),
                    DataCell(Text(entry.sittingAreaCompStatus ?? '')),
                    // Null check for status
                    DataCell(Text(entry.date ?? '')),
                    // Display date as-is (assuming it's already formatted)
                    DataCell(Text(entry.time ?? '')),
                    // Display time as-is (assuming it's already formatted)
                  ]);
                }).toList(),
              ),
            );
          }),
        ),
      );

  }
}
