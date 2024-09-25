import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/asphalt_work_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;

class AsphaltWorkSummary extends StatelessWidget {
  final AsphaltWorkViewModel asphaltWorkViewModel = Get.put(AsphaltWorkViewModel());
  void initState() => asphaltWorkViewModel.fetchAllAsphalt();

  final List<Map<String, dynamic>> backfillingDataList = [
    {"block_no": "Block A", "street_no": "Street 1", "Ton No.": "2", "Status": "Done", "date": "01 Sep 2024", "time": "10:00 AM"},
    {"block_no": "Block B", "street_no": "Street 2", "Ton No.": "7","Status": "In Process", "date": "03 Sep 2024", "time": "11:00 AM"},
    {"block_no": "Block C", "street_no": "Street 3", "Ton No.": "2", "Status": "Done","date": "07 Sep 2024", "time": "12:00 PM"},
    {"block_no": "Block D", "street_no": "Street 4", "Ton No.": "1", "Status": "In Process","date": "09 Sep 2024", "time": "01:00 PM"},
  ];

  AsphaltWorkSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

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
          'Asphalt Work Summary'.tr(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: Obx(() {
          // Use Obx to rebuild when the data changes
          if (asphaltWorkViewModel.allAsphalt.isEmpty) {
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
                        color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                // Header row
                Row(
                  children: [
                    buildHeaderCell('Block No.'),
                    buildHeaderCell('Street No.'),
                    buildHeaderCell('Ton No.'),
                    buildHeaderCell('Status'),
                    buildHeaderCell('Date'),
                    buildHeaderCell('Time'),
                  ],
                ),
                const SizedBox(height: 10),
                // Data rows
                ...asphaltWorkViewModel.allAsphalt.map((entry) {
                  return Row(
                    children: [
                      buildDataCell(entry.block_no ?? 'N/A'),
                      buildDataCell(entry.street_no ?? 'N/A'),
                      buildDataCell(entry.no_of_tons ?? 'N/A'),
                      buildDataCell(entry.back_filling_status ?? 'N/A'),
                      buildDataCell(entry.date ?? 'N/A'),
                      buildDataCell(entry.time ?? 'N/A'),
                    ],
                  );
                }),
              ],
            ),
          );
        }),
      ),
    );
  }

  // Helper to build header cells
  Widget buildHeaderCell(String text) {
    return Container(
      width: 120, // Adjust as needed
      padding: const EdgeInsets.all(8.0),
      color: const Color(0xFFC69840),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  // Helper to build data cells
  Widget buildDataCell(String text) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 12.0),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}