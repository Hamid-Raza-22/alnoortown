import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/base_sub_base_compaction_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import '../../../ReusableDesigns/filter_widget.dart';


class BaseSubBaseCompactionSummary extends StatefulWidget {
  BaseSubBaseCompactionSummary({super.key});
  @override
  State<BaseSubBaseCompactionSummary> createState() =>
      _BaseSubBaseCompactionSummaryState();
}

class _BaseSubBaseCompactionSummaryState
    extends State<BaseSubBaseCompactionSummary> {
  final BaseSubBaseCompactionViewModel baseSubBaseCompactionViewModel =
  Get.put(BaseSubBaseCompactionViewModel());

  // Filtered list to store filtered data
  List filteredList = [];

  @override
  void initState() {
    super.initState();
    // Initially, show all data
    filteredList = baseSubBaseCompactionViewModel.allSubBase;
  }

  void _applyFilter(DateTime? fromDate, DateTime? toDate, String? block) {
    setState(() {
      filteredList = baseSubBaseCompactionViewModel.allSubBase.where((entry) {
        bool matchesBlock = block == null || block.isEmpty || (entry.block_no != null && entry.block_no!.contains(block));
        bool matchesFromDate = fromDate == null || (entry.start_date != null && entry.start_date!.isAfter(fromDate.subtract(const Duration(days: 1))));
        bool matchesToDate = toDate == null || (entry.expected_comp_date != null && entry.expected_comp_date!.isBefore(toDate.add(const Duration(days: 1))));

        return matchesBlock && matchesFromDate && matchesToDate;
      }).toList();
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
        title: Text(
          'base_sub_base_compaction_summary'.tr(),
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Call the FilterWidget here
            FilterWidget(
              onFilter: (DateTime? fromDate, DateTime? toDate, String? block) {
                _applyFilter(fromDate, toDate, block);
              },
            ),
            Expanded(
              child: Obx(() {
                if (filteredList.isEmpty) {
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
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 12.0,
                    headingRowColor:
                    WidgetStateProperty.all(const Color(0xFFC69840)),
                    border: const TableBorder(
                      horizontalInside:
                      BorderSide(color: Color(0xFFC69840), width: 1.0),
                      verticalInside:
                      BorderSide(color: Color(0xFFC69840), width: 1.0),
                    ),
                    columns: [
                      DataColumn(
                          label: Text('block_no'.tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('road_no'.tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('total_length'.tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('Working Hours'.tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('start_date'.tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('end_date'.tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('status'.tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('date'.tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('time'.tr(),
                              style: const TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    rows: filteredList.map((entry) {
                      String startDate = entry.start_date != null
                          ? DateFormat('d MMM yyyy').format(entry.start_date!)
                          : '';
                      String expectedCompDate = entry.expected_comp_date != null
                          ? DateFormat('d MMM yyyy').format(entry.expected_comp_date!)
                          : '';
                      return DataRow(cells: [
                        DataCell(Text(entry.block_no ?? '')),
                        DataCell(Text(entry.road_no ?? '')),
                        DataCell(Text(entry.total_length ?? '')),
                        DataCell(Text(entry.working_hours ?? '')),
                        DataCell(Text(startDate)),
                        DataCell(Text(expectedCompDate)),
                        DataCell(Text(entry.base_sub_base_comp_status ?? '')),
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
