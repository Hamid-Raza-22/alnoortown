import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;

import '../../../../../ViewModels/BuildingWorkViewModel/BoundaryWallViewModel/PillarsViewModel/pillars_fixing_view_model.dart';
import '../../../../ReusableDesigns/filter_widget.dart';


class PillarsFixingSummary extends StatefulWidget {
  @override
  PillarsFixingSummaryState createState() => PillarsFixingSummaryState();
}

class PillarsFixingSummaryState extends State<PillarsFixingSummary> {
  final PillarsFixingViewModel pillarsFixingViewModel = Get.put(PillarsFixingViewModel());

  // Initialize the state for filtering
  String? filterBlock;
  DateTime? filterFromDate;
  DateTime? filterToDate;

  @override
  void initState() {
    super.initState();
    // Fetch the data when the widget is initialized
    pillarsFixingViewModel.fetchAllPillarsFixing();
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
          'Pillars Fixing Summary',
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 8.0 : 12.0),
        child: Column(
          children: [
            FilterWidget(onFilter: (fromDate, toDate, block) {
              setState(() {
                filterFromDate = fromDate;
                filterToDate = toDate;
                filterBlock = block;
                // Call the filter method
                pillarsFixingViewModel.filterPillarFixing(filterFromDate, filterToDate, filterBlock);
              });
            }),
            Expanded(
              child: Obx(() {
                if (pillarsFixingViewModel.allPillarsFixing.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/nodata.png',
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No data available',
                          style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }

                return Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: mediaQuery.size.width * 1.5,
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                          childAspectRatio: 2.0,
                        ),
                        itemCount: pillarsFixingViewModel.allPillarsFixing.length * 5 + 5,
                        itemBuilder: (context, index) {
                          if (index < 5) {
                            return Container(
                              color: const Color(0xFFC69840),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                ['block_no'.tr(), 'No of Pillars', 'total_length'.tr(), 'date', 'time'][index],
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            );
                          } else {
                            final entryIndex = (index - 5) ~/ 5;
                            if (entryIndex < pillarsFixingViewModel.allPillarsFixing.length) {
                              final entry = pillarsFixingViewModel.allPillarsFixing[entryIndex];
                              final data = [
                                entry.block ?? 'N/A',
                                entry.no_of_pillars ?? 'N/A',
                                entry.total_length ?? 'N/A',
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
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              Text('Status: ${data[3]}', style: const TextStyle(fontSize: 14)),
                                              Text('Date: ${data[4]}', style: const TextStyle(fontSize: 14)),
                                              Text('Time: ${data[5]}', style: const TextStyle(fontSize: 14)),
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
                                            child: Text('close'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4.0),
                                  color: index % 5 == 0 ? Colors.white : const Color(0xFFEFEFEF),
                                  alignment: Alignment.center,
                                  child: Text(
                                    data[index % 5],
                                    style: const TextStyle(fontSize: 11.0),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              );
                            }
                            return Container();
                          }
                        },
                      ),
                    ),
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
