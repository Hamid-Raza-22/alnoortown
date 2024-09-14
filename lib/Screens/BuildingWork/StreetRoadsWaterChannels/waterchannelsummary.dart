import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/StreetRoadwaterChannelViewModel/street_road_water_channel_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;

class WaterChannelsSummary extends StatelessWidget {
  StreetRoadWaterChannelViewModel streetRoadWaterChannelViewModel = Get.put(StreetRoadWaterChannelViewModel());

  void initState() => streetRoadWaterChannelViewModel.fetchAllStreetRoad();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

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
          'street_roads_water_channels_summary'.tr(),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 8.0 : 16.0),  // Adjust padding for portrait/landscape
        child: Obx(() {
          if (streetRoadWaterChannelViewModel.allStreetRoad.isEmpty) {
            return Center(child: Text('No data available'));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,  // Enable horizontal scrolling
            child: Container(
              width: mediaQuery.size.width * 1.5,  // Set width to accommodate columns
              child: GridView.builder(
                shrinkWrap: true,  // Ensure GridView behaves properly in scroll
                physics: NeverScrollableScrollPhysics(),  // Disable internal scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,  // Set to 7 columns
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0,
                  childAspectRatio: isPortrait ? 2.0 : 3.0,  // Adjust aspect ratio for better display
                ),
                itemCount: streetRoadWaterChannelViewModel.allStreetRoad.length * 7 + 7,  // Account for headers and data
                itemBuilder: (context, index) {
                  if (index < 7) {
                    // Header Row for 7 columns
                    return Container(
                      color: Color(0xFFC69840),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),  // Added padding for headers
                      child: Text(
                        ['block_no'.tr(), 'road_no'.tr(), 'road_side'.tr(), 'no_of_water_channels'.tr(), 'work_status'.tr(), 'date'.tr(), 'time'.tr()][index],
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    final entryIndex = (index - 7) ~/ 7;  // Adjust for 7 columns
                    if (entryIndex < streetRoadWaterChannelViewModel.allStreetRoad.length) {
                      final entry = streetRoadWaterChannelViewModel.allStreetRoad[entryIndex];
                      final data = [
                        entry.blockNo ?? 'N/A',
                        entry.roadNo ?? 'N/A',
                        entry.roadSide ?? 'N/A',
                        entry.noOfWaterChannels ?? 'N/A',
                        entry.waterChCompStatus ?? 'N/A',
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
                                      Text(
                                        '${data[1]}',
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
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),  // Added padding for data cells
                          color: index % 7 == 0 ? Colors.white : Color(0xFFEFEFEF),  // Alternate row colors
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  data[index % 7],  // Adjust for 7 columns
                                  style: TextStyle(fontSize: 12.0),
                                  overflow: TextOverflow.ellipsis,  // Handle text overflow
                                  maxLines: 1,  // Limit to one line
                                  textAlign: TextAlign.center,  // Align text to the center
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
              ),
            ),
          );
        }),
      ),
    );
  }
}
