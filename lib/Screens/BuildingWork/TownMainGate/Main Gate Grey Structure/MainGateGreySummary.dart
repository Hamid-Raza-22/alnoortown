import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/TownMainGatesViewModel/mg_grey_structure_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;

class MainGateGreyStructureSummary extends StatelessWidget {
  MgGreyStructureViewModel mgGreyStructureViewModel = Get.put(
      MgGreyStructureViewModel());

  void initState() => mgGreyStructureViewModel.fetchAllMainGrey();

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
          'main_gate_grey_structure_summary'.tr(),
          style: const TextStyle(fontSize: 14,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: Obx(() {
          if (mgGreyStructureViewModel.allMainGrey.isEmpty) {
            return const Center(child: Text('No data available'));
          }

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 2.0, // Adjusted for better width
            ),
            itemCount: mgGreyStructureViewModel.allMainGrey.length * 4 + 4,
            // Update this to 6 columns
            itemBuilder: (context, index) {
              if (index < 4) {
                // Header Row
                return Container(
                  color: const Color(0xFFC69840),
                  alignment: Alignment.center,
                  child: Text(
                    [
                      'block_no'.tr(),
                      'work_status'.tr(),
                      'date'.tr(),
                      'time'.tr()
                    ][index],
                    style: const TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                );
              } else {
                final entryIndex = (index - 4) ~/ 4;
                if (entryIndex < mgGreyStructureViewModel.allMainGrey.length) {
                  final entry = mgGreyStructureViewModel
                      .allMainGrey[entryIndex];
                  final data = [
                    entry.blockNo ?? 'N/A',
                    entry.workStatus ?? 'N/A',
                    entry.date ?? 'N/A',
                    entry.time ?? 'N/A'
                  ];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            title: Text(
                              'Work Status | ${data[0]}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text(
                                    '${data[1]}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color(0xFFC69840),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('close'.tr()),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      color: index % 4 == 0 ? Colors.white : const Color(0xFFEFEFEF),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              data[index % 4],
                              style: const TextStyle(fontSize: 12.0),
                              overflow: TextOverflow.ellipsis,
                              // Handle overflow
                              maxLines: 1, // Limit to one line
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Container(); // Empty container for extra items
              }
            },
          );
        }),
      ),
    );
  }
}