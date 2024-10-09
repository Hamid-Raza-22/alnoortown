import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsWaterSupplyWorkViewModel/back_filling_ws_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import '../../../ReusableDesigns/filter_widget.dart';

class BackFillingWaterSupplySummary extends StatefulWidget {
  const BackFillingWaterSupplySummary({super.key});

  @override
  State<BackFillingWaterSupplySummary> createState() => _BackFillingWaterSupplySummaryState();
}

class _BackFillingWaterSupplySummaryState extends State<BackFillingWaterSupplySummary> {
  BackFillingWsViewModel backFillingWsViewModel = Get.put(BackFillingWsViewModel());
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _block;

  @override
  void initState() {
    super.initState();
    backFillingWsViewModel.fetchAllWsBackFilling();
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
          'Backfilling Water Supply Summary',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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
                  Expanded(flex: 7, child: _buildHeaderText('block_no'.tr())),
                  Expanded(flex: 7, child: _buildHeaderText('road_no'.tr())),
                  Expanded(flex: 7, child: _buildHeaderText('road_side'.tr())),
                  Expanded(flex: 7, child: _buildHeaderText('total_length'.tr())),
                  Expanded(flex: 7, child: _buildHeaderText('start_date'.tr())),
                  Expanded(flex: 7, child: _buildHeaderText('expected_comp_date'.tr())),
                  Expanded(flex: 7, child: _buildHeaderText('status'.tr())),
                  Expanded(flex: 7, child: _buildHeaderText('date'.tr())),
                  Expanded(flex: 7, child: _buildHeaderText('time'.tr())),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Filtered Data List
            Expanded(
              child: Obx(() {
                // Filter data based on selected criteria
                final filteredData = backFillingWsViewModel.allWsBackFilling.where((entry) {
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
                    final entry = filteredData[index];
                    return GestureDetector(
                      onTap: () {
                        _showDetailsDialog(context, entry);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                          color: index % 2 == 0 ? Colors.white : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 2, child: _buildDataText(entry.block_no ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.road_no ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.road_side ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.total_length ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.start_date?.toString() ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.expected_comp_date?.toString() ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.water_supply_back_filling_comp_status ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.date ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.time ?? 'N/A')),
                          ],
                        ),
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
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDataText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 12),
      textAlign: TextAlign.center,
    );
  }

  void _showDetailsDialog(BuildContext context, var entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Details | ${entry.block_no ?? 'N/A'}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Road No.: ${entry.road_no ?? 'N/A'}', style: const TextStyle(fontSize: 12)),
                Text('Road Side: ${entry.road_side ?? 'N/A'}', style: const TextStyle(fontSize: 12)),
                Text('Total Length: ${entry.total_length ?? 'N/A'}', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFC69840),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
