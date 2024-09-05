import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SittingAreaSummaryPage extends StatelessWidget {
  final List<Map<String, dynamic>> containerDataList;

    SittingAreaSummaryPage({Key? key, required this.containerDataList})
      : super(key: key);

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
          'sitting_area_work_summary'.tr(),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:   EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns:   [
                    DataColumn(
                        label: Text('type_of_work'.tr(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840)))),
                    DataColumn(
                        label: Text('start_date'.tr(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840)))),
                    DataColumn(
                        label: Text('end_date'.tr(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840)))),
                    DataColumn(
                        label: Text('status'.tr(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840)))),
                    DataColumn(
                        label: Text('date'.tr(),
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC69840)))),
                    DataColumn(
                        label: Text('time'.tr(),
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
