import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BoundaryGrillWorkSummary extends StatefulWidget {
  final List<Map<String, dynamic>> containerDataList;

  const BoundaryGrillWorkSummary({Key? key, required this.containerDataList})
      : super(key: key);

  @override
  State<BoundaryGrillWorkSummary> createState() => _BoundaryGrillWorkSummaryState();
}

class _BoundaryGrillWorkSummaryState extends State<BoundaryGrillWorkSummary> {
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
          'Boundary Grill Work Summary',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 16.0,
            headingRowColor: WidgetStateProperty.all(const Color(0xFFC69840)),
            border: const TableBorder(
              horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
              verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
            ),
            columns: const [
              DataColumn(label: Text('Start Date', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('End Date', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
            rows: widget.containerDataList.map((entry) {
              DateTime timestamp = DateTime.parse(entry['timestamp']);
              return DataRow(cells: [
                DataCell(Text(entry['startDate'] != null
                    ? DateFormat('d MMM yyyy').format(DateTime.parse(entry['startDate']))
                    : '')),
                DataCell(Text(entry['endDate'] != null
                    ? DateFormat('d MMM yyyy').format(DateTime.parse(entry['endDate']))
                    : '')),
                DataCell(Text(entry['status'] ?? '')),
                DataCell(Text(DateFormat('d MMM yyyy').format(timestamp))), // Date
                DataCell(Text(DateFormat('h:mm a').format(timestamp))), // Time
              ]);
            }).toList(),
          ),
        ),
      ),
    );
  }
}