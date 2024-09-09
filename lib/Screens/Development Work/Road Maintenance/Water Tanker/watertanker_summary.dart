import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;
import '../../../../ViewModels/DevelopmentWorksViewModel/RoadMaintenaceViewModel/tanker_view_model.dart';

class WaterTankerSummary extends StatelessWidget {
  TankerViewModel _tankerViewModel = Get.put(TankerViewModel());


  TankerViewModel tankerViewModel = Get.put(TankerViewModel());

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    _tankerViewModel.fetchAllTanker();
    tankerViewModel.fetchAllTanker();
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
          'Water Tanker Summary',
          style: TextStyle(fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: Obx(() {
          if (tankerViewModel.allTanker.isEmpty) {
            return Center(child: Text('No data available'));
          }

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              // 3 columns for 'block_no'.tr()., Street No., and No. of Tankers
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 3.0, // Adjust for better width
            ),
            itemCount: tankerViewModel.allTanker.length * 3 + 3,
            // Additional 3 for headings
            itemBuilder: (context, index) {
              if (index < 3) {
                // Header Row
                return Container(
                  color: Color(0xFFC69840),
                  alignment: Alignment.center,
                  child: Text(
                    [
                      'block_no'.tr(),
                      'street_no'.tr(),
                      'no_of_tankers'.tr(),
                      'date'.tr(),
                      'time'.tr()
                    ][index],
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                );
              } else {
                final entryIndex = (index - 3) ~/ 3;
                final column = (index - 3) % 3;
                if (entryIndex < tankerViewModel.allTanker.length) {
                  final entry = tankerViewModel.allTanker[entryIndex];
                  final data = [
                    entry.blockNo ?? 'N/A',
                    entry.streetNo ?? 'N/A',
                    entry.tankerNo ?? 'N/A',
                    entry.date ?? 'N/A',
                    entry.time ?? 'N/A'
                  ];
                  return GestureDetector(
                    onTap: () {
                      if (column == 0) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: Text(
                                'Tanker Details | ${data[0]}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: [
                                    Text(
                                      'Street No.: ${data[1]}',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      'No. of Tankers: ${data[2]}',
                                      style: TextStyle(fontSize: 16),
                                    ),
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
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      color: column % 2 == 0 ? Colors.white : Color(0xFFEFEFEF),
                      alignment: Alignment.center,
                      child: Text(
                        data[column],
                        style: TextStyle(fontSize: 12.0),
                        overflow: TextOverflow.ellipsis, // Handle overflow
                        maxLines: 1, // Limit to one line
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
