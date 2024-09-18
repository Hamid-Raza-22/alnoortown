import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/LightPolesWorkViewModel/poles_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;

class PolesSummary extends StatelessWidget {
  final PolesViewModel polesViewModel = Get.put(PolesViewModel());
  void initState() => polesViewModel.fetchAllPole();

  final List<Map<String, dynamic>> backfillingDataList = [
    {"blockNo": "Block A", "streetNo": "Street 1", "Poles No.": "1", "date": "03 Sep 2024", "time": "2:00 AM"},
    {"blockNo": "Block B", "streetNo": "Street 2", "Poles No.": "3", "date": "04 Sep 2024", "time": "7:00 AM"},
    {"blockNo": "Block C", "streetNo": "Street 3", "Poles No.": "8", "date": "08 Sep 2024", "time": "12:00 PM"},
    {"blockNo": "Block D", "streetNo": "Street 4", "Poles No.": "2", "date": "09 Sep 2024", "time": "04:00 PM"},
  ];

  PolesSummary({super.key});

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
          'Poles Summary'.tr(),
          style: TextStyle(
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
      if (polesViewModel.allPole.isEmpty) {
        return Center(child: Text('No data available'));
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
                buildHeaderCell('Poles No.'),
                buildHeaderCell('Date'),
                buildHeaderCell('Time'),
              ],
            ),
            const SizedBox(height: 10),
            // Data rows
            ...polesViewModel.allPole.map((entry) {
              return Row(
                children: [
                  buildDataCell(entry.blockNo ?? 'N/A'),
                  buildDataCell(entry.streetNo ?? 'N/A'),
                  buildDataCell(entry.noOfPoles ?? 'N/A'),
                  buildDataCell(entry.date ?? 'N/A'),
                  buildDataCell(entry.time ?? 'N/A'),
                ],
              );
            }).toList(),
          ],
        ),
      );
    }),
      ),
    );
  }

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
