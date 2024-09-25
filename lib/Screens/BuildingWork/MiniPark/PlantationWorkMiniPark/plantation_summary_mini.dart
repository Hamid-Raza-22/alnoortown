import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/mp_plantation_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' show  Get, Inst, Obx;

class Plantation_Mini_Summary extends StatefulWidget {

    Plantation_Mini_Summary({super.key});

  @override
  State<Plantation_Mini_Summary> createState() => _Plantation_Mini_SummaryState();
}

class _Plantation_Mini_SummaryState extends State<Plantation_Mini_Summary> {
  final MpPlantationWorkViewModel mpPlantationWorkViewModel = Get.put(MpPlantationWorkViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:   Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:   Text(
          'plantation_work_summary'.tr(),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:   EdgeInsets.all(16.0),
          child: Obx(() {
            // Use Obx to rebuild when the data changes
            if (mpPlantationWorkViewModel.allMpPlant.isEmpty) {
              return Center(
                  child: CircularProgressIndicator()); // Show loading indicator
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 16.0,
                headingRowColor: WidgetStateProperty.all(Color(0xFFC69840)),
                border: TableBorder(
                  horizontalInside: BorderSide(
                      color: Color(0xFFC69840), width: 1.0),
                  verticalInside: BorderSide(
                      color: Color(0xFFC69840), width: 1.0),
                ),
                columns: [
                  DataColumn(label: Text('start_date'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('end_date'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('status'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('date'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('time'.tr(),
                      style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: mpPlantationWorkViewModel.allMpPlant.map((entry) {
                  // Format the DateTime objects to a readable string format
                  String start_date = entry.start_date != null
                      ? DateFormat('d MMM yyyy').format(entry.start_date!)
                      : ''; // Show empty string if null

                  String expected_comp_date = entry.expected_comp_date != null
                      ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                      : ''; // Show empty string if null
                  return DataRow(cells: [
                    DataCell(Text(start_date)),
                    // Formatted start date
                    DataCell(Text(expected_comp_date)),
                    // Formatted expected completion date
                    DataCell(Text(entry.mini_park_plantation_comp_status ?? '')),
                    // Null check for status
                    DataCell(Text(entry.date ?? '')),
                    // Display date as-is (assuming it's already formatted)
                    DataCell(Text(entry.time ?? '')),
                    // Display time as-is (assuming it's already formatted)
                  ]);
                }).toList(),

              ),
            );
          }
    ),
      ),
    );
  }
}