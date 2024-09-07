
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsWaterSupplyWorkViewModel/back_filling_ws_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart' show  Get, Inst, Obx;

class BackFillingWaterSupplySummary extends StatefulWidget {
    const BackFillingWaterSupplySummary({super.key});

  @override
  State<BackFillingWaterSupplySummary> createState() => _BackFillingWaterSupplySummaryState();
}

class _BackFillingWaterSupplySummaryState extends State<BackFillingWaterSupplySummary> {
  BackFillingWsViewModel backFillingWsViewModel = Get.put(BackFillingWsViewModel());
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
          'roads_water_supply_summary'.tr(),
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:   const EdgeInsets.all(12.0),
          child: Obx(() {
        // Use Obx to rebuild when the data changes
        if (backFillingWsViewModel.allWsBackFilling.isEmpty) {
            return const Center(child: CircularProgressIndicator()); // Show loading indicator
    }

             return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                 child: DataTable(
            columnSpacing: 12.0,
            headingRowColor: WidgetStateProperty.all(  const Color(0xFFC69840)),
            border:  const TableBorder(
              horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
              verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
            ),
            columns:   [
              DataColumn(label: Text('block_no'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('road_no'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('road_side'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('total_length'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('start_date'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('end_date'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('status'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('date'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('time'.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: backFillingWsViewModel.allWsBackFilling.map((entry) {
              // Format the DateTime objects to a readable string format
              String startDate = entry.startDate != null
                  ? DateFormat('d MMM yyyy').format(entry.startDate!)
                  : ''; // Show empty string if null

              String expectedCompDate = entry.expectedCompDate != null
                  ? DateFormat('d MMM yyyy').format(entry.expectedCompDate!)
                  : '';
              return DataRow(cells: [
                DataCell(Text(startDate )),
                DataCell(Text(expectedCompDate )),
                DataCell(Text(entry.blockNo!)),
                DataCell(Text(entry.roadNo!)),
                DataCell(Text(entry.roadSide!)),
                DataCell(Text(entry.totalLength!)),
                DataCell(Text(entry.waterSupplyBackFillingCompStatus!)),
                DataCell(Text(entry.date !)),
                DataCell(Text(entry.time !)),
              ]);
            }).toList(),
          ),
    );
          }),
      ),
    );
  }
}
