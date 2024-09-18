import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsEdgingWorksViewModel/roads_edging_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../ReusableDesigns/filter_widget.dart';

class RoadsEdgingSummary extends StatefulWidget {
  const RoadsEdgingSummary({super.key});

  @override
  _RoadsEdgingSummaryState createState() => _RoadsEdgingSummaryState();
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
          icon: const Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'roads_edging_summary',
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
                  return const Center(child: CircularProgressIndicator()); // Show loading indicator
                }

                // Filter data based on the selected criteria
                var filteredData = roadsEdgingWorkViewModel.allRoadEdging.where((entry) {
                  final entryStartDate = entry.startDate != null ? DateTime.tryParse(entry.startDate! as String) : null;
                  final entryEndDate = entry.expectedCompDate != null ? DateTime.tryParse(entry.expectedCompDate! as String) : null;

                  bool matchesDate = true;
                  if (selectedFromDate != null && selectedToDate != null) {
                    if (entryStartDate != null && entryEndDate != null) {
                      matchesDate = (entryStartDate.isAfter(selectedFromDate!) || entryStartDate.isAtSameMomentAs(selectedFromDate!))
                          && (entryEndDate.isBefore(selectedToDate!) || entryEndDate.isAtSameMomentAs(selectedToDate!));
                    } else {
                      matchesDate = false;
                    }
                  }

                  bool matchesBlock = selectedBlock == null || (entry.blockNo?.toLowerCase().contains(selectedBlock!.toLowerCase()) ?? false);
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
                      String startDate = entry.startDate != null
                          ? DateFormat('d MMM yyyy').format(DateTime.parse(entry.startDate! as String))
                          : ''; // Show empty string if null

                      String expectedCompDate = entry.expectedCompDate != null
                          ? DateFormat('d MMM yyyy').format(DateTime.parse(entry.expectedCompDate! as String))
                          : ''; // Show empty string if null

                      return DataRow(cells: [
                        DataCell(Text(startDate)),
                        DataCell(Text(entry.blockNo ?? '')),
                        DataCell(Text(entry.roadNo ?? '')),
                        DataCell(Text(entry.roadSide ?? '')),
                        DataCell(Text(entry.totalLength ?? '')),
                        DataCell(Text(expectedCompDate)),
                        DataCell(Text(entry.roadsEdgingCompStatus ?? '')),
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
