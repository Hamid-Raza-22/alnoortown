import 'package:easy_localization/easy_localization.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/ceiling_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import 'package:intl/intl.dart';
import '../../../ReusableDesigns/filter_widget.dart';

class CeilingWorkSummary extends StatefulWidget {
  CeilingWorkSummary({super.key});

  @override
  State<CeilingWorkSummary> createState() => _CeilingWorkSummaryState();
}

class _CeilingWorkSummaryState extends State<CeilingWorkSummary> {
  final CeilingWorkViewModel ceilingWorkViewModel = Get.put(CeilingWorkViewModel());

  DateTime? _fromDate;
  DateTime? _toDate;
  String? _block;

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
          'ceiling_work_summary'.tr(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Filter Widget
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

            // Table Header
            Container(
              color: const Color(0xFFC69840),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: _buildHeaderCell('block_no'.tr())),
                    Expanded(child: _buildHeaderCell('status'.tr())),
                    Expanded(child: _buildHeaderCell('date'.tr())),
                    Expanded(child: _buildHeaderCell("time".tr())),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Data Grid
            Expanded(
              child: Obx(() {
                // Apply filters to the data
                final filteredData = ceilingWorkViewModel.allCeiling.where((data) {
                  final blockMatch = _block == null || data.block_no.toLowerCase().contains(_block!.toLowerCase());

                  // Parse the date string to DateTime
                  DateTime? dataDate;
                  try {
                    dataDate = DateTime.parse(data.date); // Assuming data.date is a string
                  } catch (e) {
                    // Handle parsing error
                    dataDate = null;
                  }

                  final dateMatch = (dataDate == null) ||
                      (_fromDate == null || dataDate.isAfter(_fromDate!)) &&
                          (_toDate == null || dataDate.isBefore(_toDate!));

                  return blockMatch && dateMatch;
                }).toList();

                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final data = filteredData[index];
                    return _buildDataRow({
                      "selectedBlock": data.block_no,
                      "status": data.ceiling_work_status,
                      "date": data.date,
                      "time": data.time,
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

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('d MMM yyyy').format(date);
    } catch (e) {
      return "N/A";
    }
  }

  String _formatTime(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('h:mm a').format(date);
    } catch (e) {
      return "N/A";
    }
  }

  Widget _buildHeaderCell(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
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
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: _buildDataCell(data["selectedBlock"] ?? "N/A")),
            Expanded(child: _buildDataCell(data["status"] ?? "N/A")),
            Expanded(child: _buildDataCell(data["date"])),
            Expanded(child: _buildDataCell(data["time"])),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCell(String? text) {
    return Center(
      child: Text(
        text ?? "N/A",
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFFC69840),
        ),
      ),
    );
  }
}
