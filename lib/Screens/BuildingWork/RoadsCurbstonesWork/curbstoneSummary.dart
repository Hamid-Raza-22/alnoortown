import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Models/BuildingWorkModels/RoadsCurbstonesWorkModel/road_curb_stones_work_model.dart';
import '../../../ViewModels/BuildingWorkViewModel/RoadsCurbstonesWorkViewModel/road_curb_stones_work_view_model.dart';
import '../../ReusableDesigns/filter_widget.dart';

class RoadsCurbstonesWorkSummary extends StatelessWidget {
  final RoadCurbStonesWorkViewModel roadCurbStonesWorkViewModel = Get.put(RoadCurbStonesWorkViewModel());

  // Variables to store filter criteria
  DateTime? fromDate;
  DateTime? toDate;
  String? selectedBlock;

  List<RoadCurbStonesWorkModel> getFilteredData() {
    return roadCurbStonesWorkViewModel.allRoadCurb.where((entry) {
      bool matchesDateRange = true;
      bool matchesBlock = true;

      if (fromDate != null && toDate != null) {
        matchesDateRange = entry.date != null &&
            entry.date!.isAfter(fromDate!) &&
            entry.date!.isBefore(toDate!);
      }

      if (selectedBlock != null && selectedBlock!.isNotEmpty) {
        matchesBlock = entry.block_no == selectedBlock;
      }

      return matchesDateRange && matchesBlock;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

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
          'curbstones_work_summary'.tr,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: Column(
          children: [
            // Add FilterWidget above the grid
            FilterWidget(
              onFilter: (DateTime? from, DateTime? to, String? block) {
                // Update the state with selected filter values
                fromDate = from;
                toDate = to;
                selectedBlock = block;
              },
            ),
            Expanded(
              child: Obx(() {
                if (roadCurbStonesWorkViewModel.allRoadCurb.isEmpty) {
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
                          style: TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }

                List<RoadCurbStonesWorkModel> filteredData = getFilteredData();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      // Header row
                      Row(
                        children: [
                          buildHeaderCell('block_no'.tr),
                          buildHeaderCell('road_no'.tr),
                          buildHeaderCell('total_length'.tr),
                          buildHeaderCell('status'.tr),
                          buildHeaderCell('date'.tr),
                          buildHeaderCell('time'.tr),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Data rows
                      ...filteredData.map((entry) {
                        return Row(
                          children: [
                            buildDataCell(entry.block_no ?? 'N/A'),
                            buildDataCell(entry.roadNo ?? 'N/A'),
                            buildDataCell(entry.totalLength ?? 'N/A'),
                            buildDataCell(entry.compStatus ?? 'N/A'),
                            buildDataCell(entry.date ?? 'N/A'),
                            buildDataCell(entry.time ?? 'N/A'),
                          ],
                        );
                      }),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderCell(String text) {
    return Container(
      width: 120, // Adjust width as necessary
      padding: const EdgeInsets.all(8.0),
      color: const Color(0xFFC69840),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  // Helper to build data cells
  Widget buildDataCell(String text) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 12.0),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
