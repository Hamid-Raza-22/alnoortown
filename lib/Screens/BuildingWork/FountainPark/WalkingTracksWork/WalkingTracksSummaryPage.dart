import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/FountainParkViewModel/walking_tracks_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import '../../../ReusableDesigns/filter_widget.dart';

class WalkingTracksSummaryPage extends StatefulWidget {
  WalkingTracksSummaryPage({super.key});

  @override
  State<WalkingTracksSummaryPage> createState() => _WalkingTracksSummaryPageState();
}

class _WalkingTracksSummaryPageState extends State<WalkingTracksSummaryPage> {
  final WalkingTracksWorkViewModel walkingTracksWorkViewModel = Get.put(WalkingTracksWorkViewModel());
  DateTime? _startDate;
  DateTime? _endDate;
  String? _status;

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
            // Add the FilterWidget here
            FilterWidget(
              onFilter: (startDate, endDate, status) {
                setState(() {
                  _startDate = startDate;
                  _endDate = endDate;
                  _status = status;
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

              // Filter the data
              final filteredData = walkingTracksWorkViewModel.allWalking.where((entry) {
                // Filter by start date
                final startDateMatch = _startDate == null ||
                    (entry.startDate != null && entry.startDate!.isAfter(_startDate!));

                // Filter by end date
                final endDateMatch = _endDate == null ||
                    (entry.expectedCompDate != null && entry.expectedCompDate!.isBefore(_endDate!));

                // Filter by status
                final statusMatch = _status == null ||
                    (entry.walkingTracksCompStatus != null &&
                        entry.walkingTracksCompStatus!.toLowerCase().contains(_status!.toLowerCase()));

                return startDateMatch && endDateMatch && statusMatch;
              }).toList();

              // Show "No data available" if the list is empty
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
                    String startDate = entry.startDate != null
                        ? DateFormat('d MMM yyyy').format(entry.startDate!)
                        : ''; // Show empty string if null

                    String expectedCompDate = entry.expectedCompDate != null
                        ? DateFormat('d MMM yyyy').format(entry.expectedCompDate!)
                        : ''; // Show empty string if null

                    return DataRow(cells: [
                      DataCell(Text(entry.typeOfWork ?? '')),
                      DataCell(Text(startDate)),
                      DataCell(Text(expectedCompDate)),
                      DataCell(Text(entry.walkingTracksCompStatus ?? '')),
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
