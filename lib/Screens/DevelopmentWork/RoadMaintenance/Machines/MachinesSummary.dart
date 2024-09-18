import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/RoadMaintenaceViewModel/machine_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;

import '../../../ReusableDesigns/searchable_filters.dart';

class MachinesSummary extends StatelessWidget {
  final MachineViewModel machineViewModel = Get.put(MachineViewModel());
  void initState() => machineViewModel.fetchAllMachines();
  MachinesSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    machineViewModel.fetchAllMachines();
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
          'machines_summary'.tr(),
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
          if (machineViewModel.allMachines.isEmpty) {
            return  Center(child: Text('No data available'));
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
                    buildHeaderCell('Machine'),
                    buildHeaderCell('Date'),
                    buildHeaderCell('Time In'),
                    buildHeaderCell('Time Out'),
                    buildHeaderCell('TIme'),
                  ],
                ),
                const SizedBox(height: 10),
                // Data rows
                ...machineViewModel.allMachines.map((entry) {
                  return Row(
                    children: [
                      buildDataCell(entry.blockNo?? 'N/A'),
                      buildDataCell(entry.streetNo?? 'N/A'),
                      buildDataCell(entry.machine ?? 'N/A'),
                      buildDataCell(entry.date ?? 'N/A'),
                      buildDataCell(entry.timeIn ?? 'N/A'),
                      buildDataCell(entry.timeOut ?? 'N/A'),
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
