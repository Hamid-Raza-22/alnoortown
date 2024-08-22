import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SittingAreaSummaryPage extends StatelessWidget {
  final List<Map<String, dynamic>> containerDataList;

  const SittingAreaSummaryPage({Key? key, required this.containerDataList})
      : super(key: key);

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
          'Sitting Area Work Summary',
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                        label: Text('Type of Work',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840)))),
                    DataColumn(
                        label: Text('Start Date',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840)))),
                    DataColumn(
                        label: Text('Completion Date',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840)))),
                    DataColumn(
                        label: Text('Status',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840)))),
                    DataColumn(
                        label: Text('Date',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840)))),
                    DataColumn(
                        label: Text('Time',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840)))),
                  ],
                  rows: containerDataList.map((entry) {
                    DateTime timestamp = DateTime.parse(entry['timestamp']);
                    return DataRow(cells: [
                      DataCell(Text(entry['typeofwork'] ?? '')),
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
          ],
        ),
      ),
    );
  }
}
