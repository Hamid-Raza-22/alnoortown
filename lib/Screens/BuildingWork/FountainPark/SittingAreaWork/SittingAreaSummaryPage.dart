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
                String start_date = entry.start_date != null
                    ? DateFormat('d MMM yyyy').format(entry.start_date!)
                    : ''; // Show empty string if null

                String expected_comp_date = entry.expected_comp_date != null
                    ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                    : ''; // Show empty string if null
                return DataRow(cells: [
                  // Formatted start date

                  DataCell(Text(entry.typeOfWork ?? '')),
                  DataCell(Text(start_date)),
                  DataCell(Text(expected_comp_date)),
                  DataCell(Text(entry.sitting_area_comp_status ?? '')),
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