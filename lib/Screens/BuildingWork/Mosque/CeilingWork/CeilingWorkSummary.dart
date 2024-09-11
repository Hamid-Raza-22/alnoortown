import 'package:easy_localization/easy_localization.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/ceiling_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import 'package:intl/intl.dart';

class CeilingWorkSummary extends StatelessWidget {
  final CeilingWorkViewModel ceilingWorkViewModel = Get.put(CeilingWorkViewModel());
  //final List<Map<String, dynamic>> containerDataList;
  CeilingWorkSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:   Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:   Text(
          'ceiling_work_summary'.tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:   EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Table Header
            Container(
              color: Color(0xFFC69840),
              child: Padding(
                padding:   EdgeInsets.symmetric(vertical: 12.0),
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
              SizedBox(height: 8),
            // Data Grid
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: ceilingWorkViewModel.allCeiling.length,
                  itemBuilder: (context, index) {
                    final data = ceilingWorkViewModel.allCeiling[index];
                    return _buildDataRow({
                      "selectedBlock": data.blockNo,
                      "status": data.ceilingWorkStatus,
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

  Widget _buildHeaderCell(String title) {
    return Center(
      child: Text(
        title,
        style:   TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildDataRow(Map<String, dynamic> data) {
    return Container(
      margin:   EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFC69840), width: 1.0),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding:   EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
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
        style:   TextStyle(
          fontSize: 14,
          color: Color(0xFFC69840),
        ),
      ),
    );
  }

  // String _formatDate(String? timestamp) {
  //   if (timestamp == null) return "N/A";
  //   final dateTime = DateTime.parse(timestamp);
  //   return DateFormat('d MMM yyyy').format(dateTime);
  // }
  //
  // String _formatTime(String? timestamp) {
  //   if (timestamp == null) return "N/A";
  //   final dateTime = DateTime.parse(timestamp);
  //   return DateFormat('h:mm a').format(dateTime);
  // }
}