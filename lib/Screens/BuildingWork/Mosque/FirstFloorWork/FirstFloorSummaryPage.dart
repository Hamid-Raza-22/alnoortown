import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/first_floor_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import '../../../ReusableDesigns/filter_widget.dart';

class FirstFloorSummaryPage extends StatefulWidget {
  @override
  _FirstFloorSummaryPageState createState() => _FirstFloorSummaryPageState();
}

class _FirstFloorSummaryPageState extends State<FirstFloorSummaryPage> {
  final FirstFloorViewModel firstFloorViewModel = Get.put(FirstFloorViewModel());
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _block;

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
          'first_floor_summary'.tr(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Widget
            FilterWidget(
              onFilter: (fromDate, toDate, block) {
                setState(() {
                  _fromDate = fromDate;
                  _toDate = toDate;
                  _block = block;
                });
              },
            ),
            const SizedBox(height: 16),

            // Data headers
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFC69840),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 2, child: _buildHeaderText('block_no'.tr())),
                  Expanded(flex: 2, child: _buildHeaderText('brick_work'.tr())),
                  Expanded(flex: 2, child: _buildHeaderText('mud_filling_work'.tr())),
                  Expanded(flex: 2, child: _buildHeaderText('plaster_work'.tr())),
                  Expanded(flex: 2, child: _buildHeaderText('date'.tr())),
                  Expanded(flex: 2, child: _buildHeaderText('time'.tr())),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Obx(() {
                final filteredData = firstFloorViewModel.allFirstFloor.where((entry) {
                  // Filter logic for block and date range
                  final blockMatch = _block == null ||
                      (entry.block_no?.toLowerCase() ?? '').contains(_block!.toLowerCase());
                  DateTime? entryDate;
                  try {
                    entryDate = DateTime.parse(entry.date);
                  } catch (e) {
                    entryDate = null;
                  }
                  final dateMatch = (entryDate == null) ||
                      (_fromDate == null || entryDate.isAfter(_fromDate!)) &&
                          (_toDate == null || entryDate.isBefore(_toDate!));
                  return blockMatch && dateMatch;
                }).toList();

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

                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final data = filteredData[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                      margin: const EdgeInsets.only(bottom: 8.0),
                      decoration: BoxDecoration(
                        color: index % 2 == 0 ? Colors.white : const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 2, child: _buildDataText(data.block_no ?? 'N/A')),
                          Expanded(flex: 2, child: _buildDataText(data.brick_work ?? 'N/A')),
                          Expanded(flex: 2, child: _buildDataText(data.mud_filling ?? 'N/A')),
                          Expanded(flex: 2, child: _buildDataText(data.plaster_work ?? 'N/A')),
                          Expanded(flex: 2, child: _buildDataText(data.date ?? 'N/A')),
                          Expanded(flex: 2, child: _buildDataText(data.time ?? 'N/A')),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDataText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 10),
      textAlign: TextAlign.center,
    );
  }
}
