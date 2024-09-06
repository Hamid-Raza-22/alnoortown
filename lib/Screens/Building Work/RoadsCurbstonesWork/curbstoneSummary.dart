import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCurbstonesWorkModel/road_curb_stones_work_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;

import '../../../ViewModels/BuildingWorkViewModel/RoadsCurbstonesWorkViewModel/road_curb_stones_work_view_model.dart';

class CurbstonesWorkSummary extends StatelessWidget {
  RoadCurbStonesWorkViewModel roadCurbStonesWorkViewModel = Get.put(RoadCurbStonesWorkViewModel());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    // Fetch data when the widget is built
    roadCurbStonesWorkViewModel.fetchAllRoadCurb();

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
          'curbstones_work_summary'.tr(),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: Obx(() {
          if (roadCurbStonesWorkViewModel.allRoadCurb.isEmpty) {
            return Center(child: Text('No data available'));
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,  // Change this to 6 to match the number of columns
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 2.0,
            ),
            itemCount: roadCurbStonesWorkViewModel.allRoadCurb.length * 6 + 6,  // Update this to 6 columns
            itemBuilder: (context, index) {
              if (index < 6) {
                // Header Row with 6 columns
                return Container(
                  color: Color(0xFFC69840),
                  alignment: Alignment.center,
                  child: Text(
                    ['block_no'.tr(), 'road_no'.tr(), 'total_length'.tr(), 'status'.tr(), 'date'.tr(), 'time'.tr()][index],
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                );
              } else {
                final entryIndex = (index - 6) ~/ 6;  // Adjust this for 6 columns
                if (entryIndex < roadCurbStonesWorkViewModel.allRoadCurb.length) {
                  final entry = roadCurbStonesWorkViewModel.allRoadCurb[entryIndex];
                  final data = [
                    entry.blockNo ?? 'N/A',
                    entry.roadNo ?? 'N/A',
                    entry.totalLength ?? 'N/A',
                    entry.compStatus ?? 'N/A',
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
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text('Status: ${data[3]}', style: TextStyle(fontSize: 16)),
                                  Text('Date: ${data[4]}', style: TextStyle(fontSize: 16)),
                                  Text('Time: ${data[5]}', style: TextStyle(fontSize: 16)),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color(0xFFC69840),
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
                      padding: EdgeInsets.all(8.0),
                      color: index % 6 == 0 ? Colors.white : Color(0xFFEFEFEF),  // Change this to % 6
                      alignment: Alignment.center,
                      child: Text(
                        data[index % 6],  // Change this to % 6 to handle all 6 columns
                        style: TextStyle(fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
