
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SoilCompactionSummary extends StatefulWidget {
  final List<Map<String, dynamic>> containerDataList;

  const SoilCompactionSummary({super.key, required this.containerDataList});

  @override
  State<SoilCompactionSummary> createState() => _SoilCompactionSummaryState();
}

class _SoilCompactionSummaryState extends State<SoilCompactionSummary> {
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
          'Soil Compaction Summary',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 12.0,
            headingRowColor: MaterialStateProperty.all(const Color(0xFFC69840)),
            border: const TableBorder(
              horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
              verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
            ),
            columns: const [
              DataColumn(label: Text('Start Date', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('End Date', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Total Dumpers', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: widget.containerDataList.map((entry) {
              DateTime? startDate = entry['startDate'] != null ? DateTime.parse(entry['startDate']) : null;
              DateTime? endDate = entry['endDate'] != null ? DateTime.parse(entry['endDate']) : null;
              String dumpers = entry['dumpers'] ?? 'N/A';
              String status = entry['status'] ?? 'N/A';
              DateTime? timestamp = entry['timestamp'] != null ? DateTime.parse(entry['timestamp']) : null;

              return DataRow(cells: [
                DataCell(Text(startDate != null ? DateFormat('d MMM yyyy').format(startDate) : 'N/A')),
                DataCell(Text(endDate != null ? DateFormat('d MMM yyyy').format(endDate) : 'N/A')),
                DataCell(Text(dumpers)),
                DataCell(Text(status)),
                DataCell(Text(timestamp != null ? DateFormat('d MMM yyyy').format(timestamp) : 'N/A')),
                DataCell(Text(timestamp != null ? DateFormat('h:mm a').format(timestamp) : 'N/A')),
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}