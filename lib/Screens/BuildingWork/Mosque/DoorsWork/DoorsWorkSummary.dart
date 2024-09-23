import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import '../../../../ViewModels/BuildingWorkViewModel/Mosque/door_work_view_model.dart';
import '../../../ReusableDesigns/filter_widget.dart';
class DoorsWorkSummary extends StatefulWidget {
  DoorsWorkSummary({super.key});
  @override
  State<DoorsWorkSummary> createState() => DoorsWorkSummaryState();
}
class DoorsWorkSummaryState extends State<DoorsWorkSummary> {
  final DoorWorkViewModel doorWorkViewModel = Get.put(DoorWorkViewModel());

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
          icon: Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'doors_work_summary'.tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
            SizedBox(height: 16),

            // Table Header
            Container(
              color: Color(0xFFC69840),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: _buildHeaderCell('block_no'.tr())),
                    Expanded(child: _buildHeaderCell('status'.tr())),
                    Expanded(child: _buildHeaderCell('date'.tr())),
                    Expanded(child: _buildHeaderCell('time'.tr())),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),

            // Data Grid
            Expanded(
              child: Obx(() {
                // Apply filters to the data
                final filteredData = doorWorkViewModel.allDoor.where((data) {
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
                      "status": data.doorsWorkStatus,
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

  Widget _buildHeaderCell(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDataRow(Map<String, dynamic> data) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFC69840), width: 1.0),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
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
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFFC69840),
        ),
      ),
    );
  }

}