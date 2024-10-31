import 'package:al_noor_town/ViewModels/MaterialShiftingViewModel/material_shifting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../ReusableDesigns/filter_widget.dart';

class MaterialShiftingSummaryPage extends StatelessWidget {
  final MaterialShiftingViewModel materialShiftingViewModel = Get.put(MaterialShiftingViewModel());

  MaterialShiftingSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Material Shifting',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Filter Widget
            FilterWidget(
              onFilter: (fromDate, toDate, block) {
                materialShiftingViewModel.filterData(fromDate, toDate, block);
              },
            ),
            Expanded(
              child: Obx(() {
                var displayList = materialShiftingViewModel.filteredShifting.isNotEmpty
                    ? materialShiftingViewModel.filteredShifting
                    : materialShiftingViewModel.allShifting;
                if (displayList.isEmpty) {
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
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        // Header Row
                        Row(
                          children: [
                            buildHeaderCell('From Block'),
                            buildHeaderCell('To Block'),
                            buildHeaderCell('Details'),
                            buildHeaderCell('Shifts'),
                            buildHeaderCell('Date'),
                            buildHeaderCell('Time'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Data Rows
                        Column(
                          children: displayList.map((entry) {
                            return Row(
                              children: [
                                buildDataCell(entry.from_block ?? 'N/A'),
                                buildDataCell(entry.to_block ?? 'N/A'),
                                buildDataCell(entry.details ?? 'N/A'),
                                buildDataCell(entry.no_of_shift ?? 'N/A'),
                                buildDataCell(entry.date ?? 'N/A'),
                                buildDataCell(entry.time ?? 'N/A'),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
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
        style: const TextStyle(fontSize: 14.0),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
