import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../ViewModels/BuildingWorkViewModel/Mosque/mosque_excavation_view_model.dart';
import '../../../ReusableDesigns/filter_widget.dart';

class MosqueSummaryPage extends StatefulWidget {
  MosqueSummaryPage({super.key});

  @override
  State<MosqueSummaryPage> createState() => _MosqueSummaryPageState();
}

class _MosqueSummaryPageState extends State<MosqueSummaryPage> {
  final MosqueExcavationViewModel mosqueViewModel = Get.put(MosqueExcavationViewModel());
  DateTime? fromDate;
  DateTime? toDate;
  String? block;

  String? errorMessage; // For showing no data available

  void _applyFilter(DateTime? fromDate, DateTime? toDate, String? block) {
    setState(() {
      this.fromDate = fromDate;
      this.toDate = toDate;
      this.block = block;
    });
  }

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
          'summary',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FilterWidget(onFilter: _applyFilter),
          Expanded(
            child: Obx(() {
              final filteredData = mosqueViewModel.allMosque.where((data) {
                bool matchesDate = (fromDate == null || data.date.isAfter(fromDate!)) &&
                    (toDate == null || data.date.isBefore(toDate!));
                bool matchesBlock = block == null || block!.isEmpty || data.blockNo.toLowerCase() == block!.toLowerCase();
                return matchesDate && matchesBlock;
              }).toList();

              if (filteredData.isEmpty) {
                return Center(
                  child: Text(
                    errorMessage ?? "No data available for the selected criteria.",
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                itemCount: filteredData.length,
                itemBuilder: (context, index) {
                  final data = filteredData[index];
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
