
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/paint_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaintWorkSummary extends StatefulWidget {
  final List<Map<String, dynamic>> containerDataList;

  const PaintWorkSummary({super.key, required this.containerDataList});

  @override
  State<PaintWorkSummary> createState() => _PaintWorkSummaryState();
}

class _PaintWorkSummaryState extends State<PaintWorkSummary> {
  final PaintWorkViewModel paintWorkViewModel = Get.put(PaintWorkViewModel());
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
          'Paint Work Summary',
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
              child: Obx(() {
                return ListView.builder(
                  itemCount: paintWorkViewModel.allPaint.length,
                  itemBuilder: (context, index) {
                    final data = paintWorkViewModel.allPaint[index];
                    return _buildDataRow({
                      "selectedBlock": data.blockNo,
                      "status": data.paintWorkStatus,
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
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(child: _buildCell(data["selectedBlock"])),
            Expanded(child: _buildCell(data["status"])),
            Expanded(child: _buildCell(DateFormat('dd/MM/yyyy').format(DateTime.parse(data["timestamp"])))),
            Expanded(child: _buildCell(DateFormat('HH:mm').format(DateTime.parse(data["timestamp"])))),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String? content) {
    return Center(
      child: Text(
        content ?? '',
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFFC69840),
        ),
      ),
    );
  }
}