import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../../ViewModels/BuildingWorkViewModel/Mosque/mosque_excavation_view_model.dart'; // Import GetX package

class MosqueSummaryPage extends StatefulWidget {
  const MosqueSummaryPage({super.key});

  @override
  State<MosqueSummaryPage> createState() => _MosqueSummaryPageState();
}

class _MosqueSummaryPageState extends State<MosqueSummaryPage> {
  // Initialize ViewModel using GetX
  final MosqueExcavationViewModel mosqueViewModel = Get.put(MosqueExcavationViewModel());
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
          'Summary',
          style: TextStyle(
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
            // Table Header
            Container(
              color: const Color(0xFFC69840),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(child: _buildHeaderCell("Block No")),
                    Expanded(child: _buildHeaderCell("Status")),
                    Expanded(child: _buildHeaderCell("Date")),
                    Expanded(child: _buildHeaderCell("Time")),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Data Grid
            Expanded(
              // Use Obx to listen for changes in allMosque list
              child: Obx(() {
                return ListView.builder(
                  itemCount: mosqueViewModel.allMosque.length,
                  itemBuilder: (context, index) {
                    final data = mosqueViewModel.allMosque[index];
                    return _buildDataRow({
                      "selectedBlock": data.blockNo,
                      "status": data.completionStatus,
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
