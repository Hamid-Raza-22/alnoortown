import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/MainDrainWorkViewModel/man_holes_slab_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;

class ManholesSlabSummary extends StatelessWidget {
  final ManHolesSlabViewModel manHolesSlabViewModel = Get.put(ManHolesSlabViewModel());
  void initState() => manHolesSlabViewModel.fetchAllMan();
  final List<Map<String, dynamic>> backfillingDataList = [
    {"blockNo": "Block A", "streetNo": "Street 1", "Slab No.": "12", "date": "01 Sep 2024", "time": "10:00 AM"},
    {"blockNo": "Block B", "streetNo": "Street 2", "Slab No.": "7", "date": "03 Sep 2024", "time": "11:00 AM"},
    {"blockNo": "Block C", "streetNo": "Street 3", "Slab No.": "8", "date": "07 Sep 2024", "time": "12:00 PM"},
    {"blockNo": "Block D", "streetNo": "Street 4", "Slab No.": "3", "date": "09 Sep 2024", "time": "01:00 PM"},
  ];

  ManholesSlabSummary({super.key});

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
          'Manholes Slab Summary'.tr(),
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
      if (manHolesSlabViewModel.allMan.isEmpty) {
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
                buildHeaderCell('Slab No.'),
                buildHeaderCell('Date'),
                buildHeaderCell('Time'),
              ],
            ),
            const SizedBox(height: 10),
            // Data rows
            ...manHolesSlabViewModel.allMan.map((entry) {
              return Row(
                children: [
                  buildDataCell(entry.blockNo ?? 'N/A'),
                  buildDataCell(entry.streetNo ?? 'N/A'),
                  buildDataCell(entry.numOfCompSlab ?? 'N/A'),
                  buildDataCell(entry.date ?? 'N/A'),
                  buildDataCell(entry.time ?? 'N/A'),
                ],
              );
            }).toList(),
          ],
        ),
      );
    } ),
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
