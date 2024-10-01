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
    waterTankerViewModel.fetchAndSaveTankerData();
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
          icon: Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Water Tanker Summary',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Widget
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

            // Data headers
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
              decoration: BoxDecoration(
                color: const Color(0xFFC69840),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 2, child: _buildHeaderText('block_no'.tr())),
                  Expanded(flex: 2, child: _buildHeaderText('street_no'.tr())),
                  Expanded(flex: 2, child: _buildHeaderText('no_of_tankers'.tr())),
                  Expanded(flex: 2, child: _buildHeaderText('date'.tr())),
                  Expanded(flex: 2, child: _buildHeaderText('time'.tr())),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Filtered Data List
            Expanded(
              child: Obx(() {
                // Filter data based on selected criteria
                final filteredData = waterTankerViewModel.allTanker.where((entry) {
                  // Filter by block with null safety
                  final blockMatch = _block == null ||
                      (entry.block_no?.toLowerCase() ?? '').contains(_block!.toLowerCase());

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

                // Scrollable list of filtered data
                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final entry = filteredData[index];
                    return GestureDetector(
                      onTap: () {
                        _showTankerDetailsDialog(context, entry);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                        margin: const EdgeInsets.only(bottom: 8.0),
                        decoration: BoxDecoration(
                          color: index % 2 == 0 ? Colors.white : const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(flex: 2, child: _buildDataText(entry.block_no ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.street_no ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.tanker_no ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.date ?? 'N/A')),
                            Expanded(flex: 2, child: _buildDataText(entry.time ?? 'N/A')),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildDataText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 14),
      textAlign: TextAlign.center,
    );
  }

  void _showTankerDetailsDialog(BuildContext context, var entry) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Tanker Details | ${entry.block_no ?? 'N/A'}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Street No.: ${entry.street_no ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
                Text('No. of Tankers: ${entry.tanker_no ?? 'N/A'}', style: const TextStyle(fontSize: 16)),
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

}
