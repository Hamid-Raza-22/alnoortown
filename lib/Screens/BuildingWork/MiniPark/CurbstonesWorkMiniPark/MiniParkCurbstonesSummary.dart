import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../ViewModels/BuildingWorkViewModel/MiniParksViewModel/mini_park_curb_stone_view_model.dart';
import '../../../ReusableDesigns/DateFilter.dart';


class MiniParkCurbstonesSummary extends StatefulWidget {
  MiniParkCurbstonesSummary({super.key});

  @override
  State<MiniParkCurbstonesSummary> createState() => _MiniParkCurbstonesSummaryState();
}

class _MiniParkCurbstonesSummaryState extends State<MiniParkCurbstonesSummary> {
  MiniParkCurbStoneViewModel miniParkCurbStoneViewModel = Get.put(MiniParkCurbStoneViewModel());

  DateTime? fromDate;
  DateTime? toDate;

  // Filter the data based on the selected date range
  List<dynamic> getFilteredData() {
    if (fromDate == null && toDate == null) {
      return miniParkCurbStoneViewModel.allMpCurb;
    }

    return miniParkCurbStoneViewModel.allMpCurb.where((entry) {
      DateTime entryDate = entry.startDate ?? DateTime.now(); // Adjust this to your date field
      if (fromDate != null && entryDate.isBefore(fromDate!)) {
        return false;
      }
      if (toDate != null && entryDate.isAfter(toDate!)) {
        return false;
      }
      return true;
    }).toList();
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
          'Curbstones Work Summary',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date filter widget
            SearchByDate(
              onFilter: (from, to) {
                setState(() {
                  fromDate = from;
                  toDate = to;
                });
              },
            ),
            const SizedBox(height: 16),

            // Display filtered data with scrollable vertical and horizontal views
            Expanded(
              child: Obx(() {
                List<dynamic> filteredData = getFilteredData();
                if (filteredData.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/nodata.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No data available',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,  // For vertical scrolling
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,  // For horizontal scrolling
                    child: DataTable(
                      columnSpacing: 10.0,
                      headingRowColor: MaterialStateProperty.all(const Color(0xFFC69840)),
                      border: const TableBorder(
                        horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                        verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                      ),
                      columns: [
                        const DataColumn(
                          label: Text(
                            'Start Date',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),  // Smaller font size
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            'End Date',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            'Date',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                        const DataColumn(
                          label: Text(
                            'Time',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                        ),
                      ],
                      rows: filteredData.map((entry) {
                        String startDate = entry.startDate != null
                            ? DateFormat('d MMM yyyy').format(entry.startDate!)
                            : '';
                        String expectedCompDate = entry.expectedCompDate != null
                            ? DateFormat('d MMM yyyy').format(entry.expectedCompDate!)
                            : '';
                        return DataRow(
                          cells: [
                            DataCell(
                              Text(
                                startDate,
                                style: const TextStyle(fontSize: 12),  // Smaller font size
                              ),
                            ),
                            DataCell(
                              Text(
                                expectedCompDate,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            DataCell(
                              Text(
                                entry.mpCurbStoneCompStatus ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            DataCell(
                              Text(
                                entry.date ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                            DataCell(
                              Text(
                                entry.time ?? '',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
