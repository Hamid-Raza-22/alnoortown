import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/StreetRoadwaterChannelViewModel/street_road_water_channel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ReusableDesigns/filter_widget.dart';

class WaterChannelsSummary extends StatefulWidget {
  const WaterChannelsSummary({super.key});

  @override
  _WaterChannelsSummaryState createState() => _WaterChannelsSummaryState();
}

class _WaterChannelsSummaryState extends State<WaterChannelsSummary> {
  final StreetRoadWaterChannelViewModel streetRoadWaterChannelViewModel = Get.put(StreetRoadWaterChannelViewModel());

  String? _blockNo;
  String? _roadNo;
  String? _status;

  @override
  void initState() {
    super.initState();
    streetRoadWaterChannelViewModel.fetchAllStreetRoad();
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
          'street_roads_water_channels_summary'.tr,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: Column(
          children: [
            FilterWidget(
              onFilter: (blockNo, roadNo, status) {
                setState(() {
                  _blockNo = blockNo as String?;
                  _roadNo = roadNo as String?;
                  _status = status;
                });
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (streetRoadWaterChannelViewModel.allStreetRoad.isEmpty) {
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
                        const SizedBox(height: 16),
                        const Text(
                          'No data available',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }
                final filteredData = streetRoadWaterChannelViewModel.allStreetRoad.where((entry) {
                  final blockNoMatch = _blockNo == null || _blockNo!.isEmpty || entry.blockNo == _blockNo;
                  final roadNoMatch = _roadNo == null || _roadNo!.isEmpty || entry.roadNo == _roadNo;
                  final statusMatch = _status == null || _status!.isEmpty || entry.waterChCompStatus == _status;

                  return blockNoMatch && roadNoMatch && statusMatch;
                }).toList();

                if (filteredData.isEmpty) {
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
                        const SizedBox(height: 16),
                        const Text(
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
                  child: SizedBox(
                    width: mediaQuery.size.width * 1.5,
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        crossAxisSpacing: 1.0,
                        mainAxisSpacing: 1.0,
                        childAspectRatio: isPortrait ? 2.0 : 3.0,
                      ),
                      itemCount: filteredData.length * 7 + 7,
                      itemBuilder: (context, index) {
                        if (index < 7) {
                          // Header Row for 7 columns
                          return Container(
                            color: const Color(0xFFC69840),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                            child: Text(
                              ['block_no'.tr, 'road_no'.tr, 'road_side'.tr, 'no_of_water_channels'.tr, 'work_status'.tr, 'date'.tr, 'time'.tr][index],
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          final entryIndex = (index - 7) ~/ 7;  // Adjust for 7 columns
                          if (entryIndex < filteredData.length) {
                            final entry = filteredData[entryIndex];
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
                                padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
                                color: index % 7 == 0 ? Colors.white : const Color(0xFFEFEFEF),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data[index % 7],
                                        style: const TextStyle(fontSize: 12.0),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container();
                        }
                      },
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
