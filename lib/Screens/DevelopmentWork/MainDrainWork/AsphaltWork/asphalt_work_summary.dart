import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/asphalt_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;

import '../../../ReusableDesigns/filter_widget.dart';

class AsphaltWorkSummary extends StatefulWidget {
  AsphaltWorkSummary({super.key});

  @override
  _AsphaltWorkSummaryState createState() => _AsphaltWorkSummaryState();
}

class _AsphaltWorkSummaryState extends State<AsphaltWorkSummary> {
  final AsphaltWorkViewModel asphaltWorkViewModel = Get.put(AsphaltWorkViewModel());

  DateTime? _fromDate;
  DateTime? _toDate;
  String? _block;

  @override
  void initState() {
    super.initState();
    asphaltWorkViewModel.fetchAllAsphalt();
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
          'Asphalt Work Summary'.tr(),
          style: const TextStyle(
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
            // Add the FilterWidget here
            FilterWidget(
              onFilter: (fromDate, toDate, block) {
                setState(() {
                  _fromDate = fromDate;
                  _toDate = toDate;
                  _block = block;
                });
              },
            ),
            const SizedBox(height: 16),

            // Data grid
            Expanded(
              child: Obx(() {
                // Filter data based on selected criteria
                final filteredData = asphaltWorkViewModel.allAsphalt.where((entry) {
                  // Filter by block
                  final blockMatch = _block == null || entry.block_no.toLowerCase().contains(_block!.toLowerCase());

                  // Parse date and check if it falls in the range
                  DateTime? entryDate;
                  try {
                    entryDate = DateTime.parse(entry.date); // Assuming date is a string
                  } catch (e) {
                    entryDate = null;
                  }

                  final dateMatch = (entryDate == null) ||
                      (_fromDate == null || entryDate.isAfter(_fromDate!)) &&
                          (_toDate == null || entryDate.isBefore(_toDate!));

                  return blockMatch && dateMatch;
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
                              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
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
                          buildHeaderCell('Ton No.'),
                          buildHeaderCell('Status'),
                          buildHeaderCell('Date'),
                          buildHeaderCell('Time'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Data rows
                      ...filteredData.map((entry) {
                        return Row(
                          children: [
                            buildDataCell(entry.block_no ?? 'N/A'),
                            buildDataCell(entry.street_no ?? 'N/A'),
                            buildDataCell(entry.no_of_tons ?? 'N/A'),
                            buildDataCell(entry.back_filling_status ?? 'N/A'),
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
