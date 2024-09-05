import 'package:easy_localization/easy_localization.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/boundary_grill_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import 'package:intl/intl.dart';

class BoundaryGrillWorkSummary extends StatefulWidget {
  const BoundaryGrillWorkSummary({super.key});

  @override
  State<BoundaryGrillWorkSummary> createState() => _BoundaryGrillWorkSummaryState();
}

class _BoundaryGrillWorkSummaryState extends State<BoundaryGrillWorkSummary> {
  final BoundaryGrillWorkViewModel boundaryGrillWorkViewModel = Get.put(BoundaryGrillWorkViewModel());

  @override
  void initState() {
    super.initState();
    boundaryGrillWorkViewModel.fetchAllBoundary(); // Fetch data on init
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
          'boundary_grill_work_summary'.tr(),
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          // Use Obx to rebuild when the data changes
          if (boundaryGrillWorkViewModel.allBoundary.isEmpty) {
            return Center(child: CircularProgressIndicator()); // Show loading indicator
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
              rows: boundaryGrillWorkViewModel.allBoundary.map((entry) {
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
                  DataCell(Text(entry.boundaryWorkCompStatus ?? '')), // Null check for status
                  DataCell(Text(entry.date ?? '')), // Display date as-is (assuming it's already formatted)
                  DataCell(Text(entry.time ?? '')), // Display time as-is (assuming it's already formatted)
                ]);
              }).toList(),

            ),
          );
        }),
      ),
    );
  }
}
