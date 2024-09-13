import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/foundation_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ReusableDesigns/filter_widget.dart';

class FoundationSummaryPage extends StatefulWidget {
  final List<Map<String, dynamic>> containerDataList;

  FoundationSummaryPage({super.key, required this.containerDataList});

  @override
  State<FoundationSummaryPage> createState() => _FoundationSummaryPageState();
}

class _FoundationSummaryPageState extends State<FoundationSummaryPage> {
  final FoundationWorkViewModel foundationWorkViewModel = Get.put(FoundationWorkViewModel());

  DateTime? fromDate;
  DateTime? toDate;
  String? blockFilter;

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
          'foundation_work_summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Insert the FilterWidget here
            FilterWidget(
              onFilter: (selectedFromDate, selectedToDate, selectedBlock) {
                setState(() {
                  fromDate = selectedFromDate;
                  toDate = selectedToDate;
                  blockFilter = selectedBlock;
                });
              },
            ),
            const SizedBox(height: 4),
            // Data Grid
            Expanded(
              child: Obx(() {
                // Apply filters to the data
                var filteredData = foundationWorkViewModel.allFoundation.where((data) {
                  bool matchesDate = true;
                  bool matchesBlock = true;

                  // Filter by date range
                  if (fromDate != null && toDate != null) {
                    DateTime dataDate = DateTime.parse(data.date); // Assuming date is stored in string format
                    matchesDate = dataDate.isAfter(fromDate!) && dataDate.isBefore(toDate!);
                  }

                  // Filter by block number
                  if (blockFilter != null && blockFilter!.isNotEmpty) {
                    matchesBlock = data.blockNo.trim() == blockFilter!.trim();
                  }

                  return matchesDate && matchesBlock;
                }).toList();

                if (filteredData.isEmpty) {
                  return const Center(
                    child: Text(
                      "No data available for the selected criteria.",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final data = filteredData[index];
                    return _buildDataRow({
                      "selectedBlock": data.blockNo,
                      "brickWorkStatus": data.brickWork,
                      "mudFillingStatus": data.mudFiling,
                      "plasterWorkStatus": data.plasterWork,
                      "date": data.date,
                      "time": data.time
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFC69840), width: 1.0),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          children: [
            _buildDataCell('block_no', data["selectedBlock"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell('brick_work', data["brickWorkStatus"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell('mud_filling_work', data["mudFillingStatus"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell('plaster_work', data["plasterWorkStatus"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildDataCell('date', data["date"])),
                Expanded(child: _buildDataCell('time', data["time"])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCell(String label, String? text) {
    return Row(
      children: [
        Text(
          "$label: ",
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        Expanded(
          child: Text(
            text ?? "N/A",
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
