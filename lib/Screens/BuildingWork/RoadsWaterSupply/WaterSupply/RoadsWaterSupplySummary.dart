import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsWaterSupplyWorkViewModel/roads_water_supply_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../../ReusableDesigns/filter_widget.dart';

class RoadsWaterSupplySummary extends StatefulWidget {
  RoadsWaterSupplySummary({super.key});

  @override
  State<RoadsWaterSupplySummary> createState() => _RoadsWaterSupplySummaryState();
}

class _RoadsWaterSupplySummaryState extends State<RoadsWaterSupplySummary> {
  RoadsWaterSupplyViewModel roadsWaterSupplyViewModel = Get.put(RoadsWaterSupplyViewModel());

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
          'roads_water_supply_summary'.tr,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Add the FilterWidget
            FilterWidget(
              onFilter: (fromDate, toDate, block) {
                roadsWaterSupplyViewModel.filterData(fromDate, toDate, block);
              },
            ),
            const SizedBox(height: 16),
            Obx(() {
              // Use Obx to rebuild when the data changes
              if (roadsWaterSupplyViewModel.filteredRoadWaterSupply.isEmpty) {
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
                            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
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
                    DataColumn(label: Text('block_no'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('road_no'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('road_side'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('total_length'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('start_date'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('end_date'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('status'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('date'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('time'.tr, style: const TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: roadsWaterSupplyViewModel.filteredRoadWaterSupply.map((entry) {
                    // Format the DateTime objects to a readable string format
                    String start_date = entry.start_date != null
                        ? DateFormat('d MMM yyyy').format(entry.start_date!)
                        : ''; // Show empty string if null

                    String expected_comp_date = entry.expected_comp_date != null
                        ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                        : ''; // Show empty string if null

                    return DataRow(cells: [
                      DataCell(Text(entry.block_no ?? '')),
                      DataCell(Text(entry.road_no ?? '')),
                      DataCell(Text(entry.road_side ?? '')),
                      DataCell(Text(entry.total_length ?? '')),
                      DataCell(Text(start_date)),
                      DataCell(Text(expected_comp_date)),
                      DataCell(Text(entry.roads_water_supply_comp_status ?? '')),
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
