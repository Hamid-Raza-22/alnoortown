import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/TownMainGatesViewModel/main_gate_pillar_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ReusableDesigns/filter_widget.dart';

class MainGatePillarsBrickSummary extends StatefulWidget {
  @override
  _MainGatePillarsBrickSummaryState createState() => _MainGatePillarsBrickSummaryState();
}

class _MainGatePillarsBrickSummaryState extends State<MainGatePillarsBrickSummary> {
  MainGatePillarWorkViewModel mainGatePillarWorkViewModel = Get.put(MainGatePillarWorkViewModel());

  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  String? selectedBlock;

  @override
  void initState() {
    super.initState();
    mainGatePillarWorkViewModel.fetchAllMainPillar();
  }

  void _onFilter(DateTime? fromDate, DateTime? toDate, String? block) {
    setState(() {
      selectedFromDate = fromDate;
      selectedToDate = toDate;
      selectedBlock = block;
    });
  }

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
          'main_gate_pillars_brick_summary'.tr,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: Column(
          children: [
            FilterWidget(onFilter: _onFilter),
            Expanded(
              child: Obx(() {
                if (mainGatePillarWorkViewModel.allMainPillar.isEmpty) {
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

                // Filter data based on the selected criteria
                var filteredData = mainGatePillarWorkViewModel.allMainPillar.where((entry) {
                  final entryDate = entry.date != null ? DateTime.tryParse(entry.date!) : null;
                  bool matchesDate = true;
                  if (selectedFromDate != null && selectedToDate != null) {
                    if (entryDate != null) {
                      matchesDate = entryDate.isAfter(selectedFromDate!) && entryDate.isBefore(selectedToDate!);
                    }
                  }
                  bool matchesBlock = selectedBlock == null || (entry.block_no?.toLowerCase().contains(selectedBlock!.toLowerCase()) ?? false);
                  return matchesDate && matchesBlock;
                }).toList();

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 2.0, // Adjusted for better width
                  ),
                  itemCount: filteredData.length * 4 + 4,
                  itemBuilder: (context, index) {
                    if (index < 4) {
                      // Header Row
                      return Container(
                        color: const Color(0xFFC69840),
                        alignment: Alignment.center,
                        child: Text(
                          ['block_no'.tr, 'work_status'.tr, 'date'.tr, 'time'.tr][index],
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      );
                    } else {
                      final entryIndex = (index - 4) ~/ 4;
                      if (entryIndex < filteredData.length) {
                        final entry = filteredData[entryIndex];
                        final data = [
                          entry.block_no ?? 'N/A',
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
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                                      child: Text('close'.tr),
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
          ],
        ),
      ),
    );
  }
}
