import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/iron_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../ReusableDesigns/filter_widget.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;

class IronWorkSummary extends StatelessWidget {
  final IronWorkViewModel ironWorkViewModel = Get.put(IronWorkViewModel());

  IronWorkSummary({super.key}) {
    // Initialize data
    ironWorkViewModel.fetchAllWorks(); // Ensure this method exists and takes no arguments
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
          'Iron Work Summary'.tr(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: Column(
          children: [
            // Add FilterWidget here
            FilterWidget(
              onFilter: (fromDate, toDate, block) {
                ironWorkViewModel.fetchAllWorks(fromDate: fromDate, toDate: toDate, block: block);
              },
            ),
            const SizedBox(height: 16), // Space between filter and grid
            Expanded(
              child: Obx(() {
                // Use Obx to rebuild when the data changes
                if (ironWorkViewModel.allWorks.isEmpty) {
                  return const Center(child: Text('No data available'));
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      // Header row
                      Row(
                        children: [
                          buildHeaderCell('Block No.'),
                          buildHeaderCell('Street No.'),
                          buildHeaderCell('Total length'),
                          buildHeaderCell('Date'),
                          buildHeaderCell('Time'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Data rows
                      ...ironWorkViewModel.allWorks.map((entry) {
                        return Row(
                          children: [
                            buildDataCell(entry.blockNo ?? 'N/A'),
                            buildDataCell(entry.streetNo ?? 'N/A'),
                            buildDataCell(entry.completedLength ?? 'N/A'),
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

  // Helper to build header cells
  Widget buildHeaderCell(String text) {
    return Container(
      width: 120, // Adjust as needed
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
