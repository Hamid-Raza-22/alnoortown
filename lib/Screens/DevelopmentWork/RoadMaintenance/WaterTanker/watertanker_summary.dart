import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/RoadMaintenaceViewModel/water_tanker_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get, Inst, Obx;
import '../../../ReusableDesigns/filter_widget.dart';

class WaterTankerSummary extends StatefulWidget {
  @override
  _WaterTankerSummaryState createState() => _WaterTankerSummaryState();
}

class _WaterTankerSummaryState extends State<WaterTankerSummary> {
 WaterTankerViewModel waterTankerViewModel = Get.put(WaterTankerViewModel());
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _block;

  @override
  void initState() {
    super.initState();
    waterTankerViewModel.fetchAllTanker();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

   // waterTankerViewModel.fetchAndSaveTankerData();
    waterTankerViewModel.fetchAllTanker();
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
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: Column(
          children: [
            // Add the FilterWidget here
            FilterWidget(
              onFilter: (fromDate, toDate, block) {
                setState(() {
                  _fromDate = fromDate;
                  _toDate = toDate;
                  _block = block;
                });
              },
            ),
            const SizedBox(height: 16),

            Expanded(
              child: Obx(() {
                // Filter data based on selected criteria
                final filteredData = waterTankerViewModel.allTanker.where((entry) {
                  // Filter by block
                  final blockMatch = _block == null || entry.block_no.toLowerCase().contains(_block!.toLowerCase());

                  // Parse date and check if it falls in the range
                  DateTime? entryDate;
                  try {
                    entryDate = DateTime.parse(entry.date); // Assuming date is a string
                  } catch (e) {
                    entryDate = null;
                  }

                  final dateMatch = (entryDate == null) ||
                      (_fromDate == null || entryDate.isAfter(_fromDate!)) &&
                          (_toDate == null || entryDate.isBefore(_toDate!));

                  return blockMatch && dateMatch;
                }).toList();

                // Show "No data available" if the list is empty
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

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0,
                    childAspectRatio: 3.0,
                  ),
                  itemCount: filteredData.length * 3 + 3,
                  itemBuilder: (context, index) {
                    if (index < 3) {
                      return Container(
                        color: const Color(0xFFC69840),
                        alignment: Alignment.center,
                        child: Text(
                          [
                            'block_no'.tr(),
                            'street_no'.tr(),
                            'no_of_tankers'.tr(),
                            'date'.tr(),
                            'time'.tr()
                          ][index],
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      );
                    } else {
                      final entryIndex = (index - 3) ~/ 3;
                      final column = (index - 3) % 3;
                      if (entryIndex < filteredData.length) {
                        final entry = filteredData[entryIndex];
                        final data = [
                          entry.block_no ?? 'N/A',
                          entry.street_no ?? 'N/A',
                          entry.tanker_no ?? 'N/A',
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 18),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          Text(
                                            'Street No.: ${data[1]}',
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            'No. of Tankers: ${data[2]}',
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
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            color: column % 2 == 0 ? Colors.white : const Color(0xFFEFEFEF),
                            alignment: Alignment.center,
                            child: Text(
                              data[column],
                              style: const TextStyle(fontSize: 12.0),
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
          ],
        ),
      ),
    );
  }
}
