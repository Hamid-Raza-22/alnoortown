import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/walking_tracks_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import '../../../ReusableDesigns/DateFilter.dart';

class WalkingTracksSummaryPage extends StatefulWidget {
  WalkingTracksSummaryPage({super.key});

  @override
  State<WalkingTracksSummaryPage> createState() => _WalkingTracksSummaryPageState();
}

class _WalkingTracksSummaryPageState extends State<WalkingTracksSummaryPage> {
  final WalkingTracksWorkViewModel walkingTracksWorkViewModel = Get.put(WalkingTracksWorkViewModel());
  DateTime? _startDate;
  DateTime? _endDate;

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
          'walking_tracks_work_summary'.tr(),
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC69840)
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Add the SearchByDate widget here
            SearchByDate(
              onFilter: (fromDate, toDate) {
                setState(() {
                  _startDate = fromDate;
                  _endDate = toDate;
                });
              },
            ),
            const SizedBox(height: 16),

            Obx(() {
              // Use Obx to rebuild when the data changes
              if (walkingTracksWorkViewModel.allWalking.isEmpty) {
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
              final filteredData = walkingTracksWorkViewModel.allWalking.where((entry) {
                final entryStartDate = entry.start_date;
                final entryEndDate = entry.expected_comp_date;
                if (_startDate == null && _endDate == null) {
                  return true;
                }
                final isAfterStartDate = _startDate == null || (entryStartDate != null && entryStartDate.isAfter(_startDate!));
                final isBeforeEndDate = _endDate == null || (entryEndDate != null && entryEndDate.isBefore(_endDate!));
                return isAfterStartDate && isBeforeEndDate;
              }).toList();
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
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(
                      label: Text("type_of_work".tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840))),
                    ),
                    DataColumn(
                      label: Text('start_date'.tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840))),
                    ),
                    DataColumn(
                      label: Text('end_date'.tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840))),
                    ),
                    DataColumn(
                      label: Text('status'.tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840))),
                    ),
                    DataColumn(
                      label: Text('date'.tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840))),
                    ),
                    DataColumn(
                      label: Text('time'.tr(),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFC69840))),
                    ),
                  ],
                  rows: filteredData.map((entry) {
                    // Format the DateTime objects to a readable string format
                    String start_date = entry.start_date != null
                        ? DateFormat('d MMM yyyy').format(entry.start_date!)
                        : ''; // Show empty string if null

                    String expected_comp_date = entry.expected_comp_date != null
                        ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                        : ''; // Show empty string if null

                    return DataRow(cells: [
                      DataCell(Text(entry.type_of_work ?? '')),
                      DataCell(Text(start_date)),
                      DataCell(Text(expected_comp_date)),
                      DataCell(Text(entry.walking_tracks_comp_status ?? '')),
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