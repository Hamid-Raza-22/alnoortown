import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsEdgingWorksViewModel/roads_edging_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../ReusableDesigns/filter_widget.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;

class RoadsEdgingSummary extends StatefulWidget {

    RoadsEdgingSummary({super.key});

  @override
  State<RoadsEdgingSummary> createState() => _RoadsEdgingSummaryState();

}

class _RoadsEdgingSummaryState extends State<RoadsEdgingSummary> {
  final RoadsEdgingWorkViewModel roadsEdgingWorkViewModel = Get.put(RoadsEdgingWorkViewModel());

  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  String? selectedBlock;

  @override
  void initState() {
    super.initState();
    roadsEdgingWorkViewModel.fetchAllRoadEdging();
  }

  void _onFilter(DateTime? fromDate, DateTime? toDate, String? block) {
    setState(() {
      selectedFromDate = fromDate;
      selectedToDate = toDate;
      selectedBlock = block;
    });
  }

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
          'roads_edging_summary'.tr(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            FilterWidget(onFilter: _onFilter),
            Expanded(
              child: Obx(() {
                if (roadsEdgingWorkViewModel.allRoadEdging.isEmpty) {
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

                // Filter data based on the selected criteria
                var filteredData = roadsEdgingWorkViewModel.allRoadEdging.where((entry) {
                  final entrystart_date = entry.start_date != null ? DateTime.tryParse(entry.start_date! as String) : null;
                  final entryEndDate = entry.expected_comp_date != null ? DateTime.tryParse(entry.expected_comp_date! as String) : null;

                  bool matchesDate = true;
                  if (selectedFromDate != null && selectedToDate != null) {
                    if (entrystart_date != null && entryEndDate != null) {
                      matchesDate = (entrystart_date.isAfter(selectedFromDate!) || entrystart_date.isAtSameMomentAs(selectedFromDate!))
                          && (entryEndDate.isBefore(selectedToDate!) || entryEndDate.isAtSameMomentAs(selectedToDate!));
                    } else {
                      matchesDate = false;
                    }
                  }

                  bool matchesBlock = selectedBlock == null || (entry.block_no?.toLowerCase().contains(selectedBlock!.toLowerCase()) ?? false);
                  return matchesDate && matchesBlock;
                }).toList();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 12.0,
                    headingRowColor: WidgetStateProperty.all(const Color(0xFFC69840)),
                    border: const TableBorder(
                      horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                      verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                    ),
                    columns: const [
                      DataColumn(label: Text('start_date', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('block_no', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('road_no', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('road_side', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('total_length', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('end_date', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('status', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('date', style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('time', style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: filteredData.map((entry) {
                      // Format the DateTime objects to a readable string format
                      String start_date = entry.start_date != null
                          ? DateFormat('d MMM yyyy').format(DateTime.parse(entry.start_date! as String))
                          : ''; // Show empty string if null

                      String expected_comp_date = entry.expected_comp_date != null
                          ? DateFormat('d MMM yyyy').format(DateTime.parse(entry.expected_comp_date! as String))
                          : ''; // Show empty string if null

                      return DataRow(cells: [
                        DataCell(Text(start_date)),
                        DataCell(Text(entry.block_no ?? '')),
                        DataCell(Text(entry.road_no ?? '')),
                        DataCell(Text(entry.road_side ?? '')),
                        DataCell(Text(entry.total_length ?? '')),
                        DataCell(Text(expected_comp_date)),
                        DataCell(Text(entry.roads_edging_comp_status ?? '')),
                        DataCell(Text(entry.date ?? '')),
                        DataCell(Text(entry.time ?? '')),
                      ]);
                    }).toList(),
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
