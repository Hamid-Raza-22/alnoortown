import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FoundationSummaryPage extends StatefulWidget {
  final List<Map<String, dynamic>> containerDataList;

  const FoundationSummaryPage({super.key, required this.containerDataList});

  @override
  State<FoundationSummaryPage> createState() => _FoundationSummaryPageState();
}

class _FoundationSummaryPageState extends State<FoundationSummaryPage> {
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
          'Foundation Work Summary',
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
            const SizedBox(height: 4),
            // Data Grid
            Expanded(
              child: ListView.builder(
                itemCount: widget.containerDataList.length,
                itemBuilder: (context, index) {
                  final data = widget.containerDataList[index];
                  return _buildDataRow(data);
                },
              ),
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
            _buildDataCell("Block No", data["selectedBlock"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell("Brick Work", data["brickWorkStatus"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell("Mud Filling", data["mudFillingStatus"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell("Plaster Work", data["plasterWorkStatus"] ?? "N/A"),
            const Divider(color: Color(0xFFC69840), thickness: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildDataCell("Date", _formatDate(data["timestamp"]))),
                Expanded(child: _buildDataCell("Time", _formatTime(data["timestamp"]))),
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

  String _formatDate(String? timestamp) {
    if (timestamp == null) return "N/A";
    final dateTime = DateTime.parse(timestamp);
    return DateFormat('d MMM yyyy').format(dateTime);
  }

  String _formatTime(String? timestamp) {
    if (timestamp == null) return "N/A";
    final dateTime = DateTime.parse(timestamp);
    return DateFormat('h:mm a').format(dateTime);
  }
}