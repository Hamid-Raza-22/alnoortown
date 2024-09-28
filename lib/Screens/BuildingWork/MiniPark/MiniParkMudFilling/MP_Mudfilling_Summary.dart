import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/MiniParksViewModel/mini_park_mud_filling_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import 'package:intl/intl.dart';
import '../../../ReusableDesigns/DateFilter.dart';

class MPMudFillingSummary extends StatefulWidget {
  MPMudFillingSummary({super.key});

  @override
  State<MPMudFillingSummary> createState() => _MPMudFillingSummaryState();
}

class _MPMudFillingSummaryState extends State<MPMudFillingSummary> {
  MiniParkMudFillingViewModel miniParkMudFillingViewModel = Get.put(MiniParkMudFillingViewModel());
  List filteredData = [];

  @override
  void initState() {
    super.initState();
    // Initially, set the filteredData to all data
    filteredData = miniParkMudFillingViewModel.allMpMud;
  }

  void filterData(DateTime? fromDate, DateTime? toDate) {
    if (fromDate == null && toDate == null) {
      // If no date is selected, show all data
      filteredData = miniParkMudFillingViewModel.allMpMud;
    } else {
      // Filter data based on selected date range
      filteredData = miniParkMudFillingViewModel.allMpMud.where((entry) {
        DateTime entryDate = entry.start_date ?? DateTime.now();
        if (fromDate != null && toDate != null) {
          return entryDate.isAfter(fromDate.subtract(Duration(days: 1))) &&
              entryDate.isBefore(toDate.add(Duration(days: 1)));
        } else if (fromDate != null) {
          return entryDate.isAfter(fromDate.subtract(Duration(days: 1)));
        } else if (toDate != null) {
          return entryDate.isBefore(toDate.add(Duration(days: 1)));
        }
        return false;
      }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'mud_filling_work_summary'.tr(),
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            // SearchByDate widget
            SearchByDate(
              onFilter: filterData,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (miniParkMudFillingViewModel.allMpMud.isEmpty) {
                  return Center(child: CircularProgressIndicator()); // Show loading indicator
                }

                if (filteredData.isEmpty) {
                  return Center(child: Text('No results found'));
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 12.0,
                    headingRowColor: MaterialStateProperty.all(Color(0xFFC69840)),
                    border: TableBorder(
                      horizontalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                      verticalInside: BorderSide(color: Color(0xFFC69840), width: 1.0),
                    ),
                    columns: [
                      DataColumn(label: Text('start_date'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('end_date'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('total_dumpers'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('status'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('date'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('time'.tr(), style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: filteredData.map((entry) {
                      String start_date = entry.start_date != null
                          ? DateFormat('d MMM yyyy').format(entry.start_date!)
                          : '';

                      String expected_comp_date = entry.expected_comp_date != null
                          ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                          : '';

                      return DataRow(cells: [
                        DataCell(Text(start_date)),
                        DataCell(Text(expected_comp_date)),
                        DataCell(Text(entry.total_dumpers ?? '')),
                        DataCell(Text(entry.mini_park_mud_filling_comp_status ?? '')),
                        DataCell(Text(entry.date ?? '')),
                        DataCell(Text(entry.time ?? '')),
                      ]);
                    }).toList(),
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
