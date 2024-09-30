import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/Mosque/foundation_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import '../../../ReusableDesigns/filter_widget.dart';

class FoundationSummaryPage extends StatefulWidget {

  FoundationSummaryPage({super.key});

  @override
  State<FoundationSummaryPage> createState() => _FoundationSummaryPageState();
}

class _FoundationSummaryPageState extends State<FoundationSummaryPage> {
  final FoundationWorkViewModel foundationWorkViewModel = Get.put(FoundationWorkViewModel());

  DateTime? fromDate;
  DateTime? toDate;
  String? blockFilter;

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
          'foundation_work_summary'.tr(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FilterWidget(
              onFilter: (selectedFromDate, selectedToDate, selectedBlock) {
                setState(() {
                  fromDate = selectedFromDate;
                  toDate = selectedToDate;
                  blockFilter = selectedBlock;
                });
              },
            ),
            SizedBox(height: 4),
            // Data Grid
            Expanded(
              child: Obx(() {
                // Apply filters to the data
                var filteredData = foundationWorkViewModel.allFoundation.where((data) {
                  bool matchesDate = true;
                  bool matchesBlock = true;

                  if (fromDate != null && toDate != null) {
                    DateTime dataDate = DateTime.parse(data.date); // Assuming date is stored in string format
                    matchesDate = dataDate.isAfter(fromDate!) && dataDate.isBefore(toDate!);
                  }

                  if (blockFilter != null && blockFilter!.isNotEmpty) {
                    matchesBlock = data.block_no == blockFilter;
                  }

                  return matchesDate && matchesBlock;
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
                        SizedBox(height: 16),
                        Text(
                          'No data available',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final data = filteredData[index];
                    return _buildDataRow({
                      "selectedBlock": data.block_no,
                      "brickWorkStatus": data.brick_work,
                      "mudFillingStatus": data.mud_filling,
                      "plasterWorkStatus": data.plaster_work,
                      "date": data.date,
                      "time": data.time
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(Map<String, dynamic> data) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFC69840), width: 1.0),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Column(
          children: [
            _buildDataCell('block_no'.tr(), data["selectedBlock"] ?? "N/A"),
            Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell('brick_work'.tr(), data["brickWorkStatus"] ?? "N/A"),
            Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell('mud_filling_work'.tr(), data["mudFillingStatus"] ?? "N/A"),
            Divider(color: Color(0xFFC69840), thickness: 1.0),
            _buildDataCell('plaster_work'.tr(), data["plasterWorkStatus"] ?? "N/A"),
            Divider(color: Color(0xFFC69840), thickness: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildDataCell('date'.tr(), data["date"])),
                Expanded(child: _buildDataCell('time'.tr(), data["time"])),
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
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        Expanded(
          child: Text(
            text ?? "N/A",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF000000),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
