import 'package:al_noor_town/ViewModels/MaterialShiftingViewModel/material_shifting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;


class MaterialShiftingSummaryPage extends StatelessWidget {
  final MaterialShiftingViewModel materialShiftingViewModel= Get.put(MaterialShiftingViewModel());
  final List<Map<String, String>> machineDataList = [
    {"fromBlock": "Block A", "toBlock": "Block B", "numOfShift": "5"},
    {"fromBlock": "Block C", "toBlock": "Block D", "numOfShift": "3"},
    {"fromBlock": "Block E", "toBlock": "Block F", "numOfShift": "7"},
    {"fromBlock": "Block G", "toBlock": "Block H", "numOfShift": "2"},
  ];

  MaterialShiftingSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final mediaQuery = MediaQuery.of(context);
    // final isPortrait = mediaQuery.orientation == Orientation.portrait;
    // materialShiftingViewModel.fetchAllShifting();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Material Shifting',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
    child: Obx(() {
      if (materialShiftingViewModel.allShifting.isEmpty) {
        return Center(child: Text('No data available'));
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 columns for headers + data
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 3.0, // Adjust aspect ratio for better visibility
        ),
        itemCount: materialShiftingViewModel.allShifting.length * 3 + 3,
        // Number of data items + headers
        itemBuilder: (context, index) {
          if (index < 3) {
            // Header Row
            return Container(
              color: const Color(0xFFC69840),
              alignment: Alignment.center,
              child: Text(
                ['From Block', 'To Block', 'Shifts','date','time'][index],
                style: const TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
            );
          } else {
            final entryIndex = (index - 3) ~/ 3;
            final columnIndex = (index - 3) % 3;

            if (entryIndex < materialShiftingViewModel.allShifting.length) {
              final entry = materialShiftingViewModel.allShifting[entryIndex];
              final data = [
                entry.fromBlock ?? 'N/A',
                entry.toBlock ?? 'N/A',
                entry.numOfShift ?? 'N/A',
                entry.date ?? 'N/A',
                entry.time ?? 'N/A'
              ];

              return Container(
                padding: const EdgeInsets.all(8.0),
                color: columnIndex % 2 == 0 ? Colors.white : const Color(
                    0xFFEFEFEF),
                alignment: Alignment.center,
                child: Text(
                  data[columnIndex],
                  style: const TextStyle(fontSize: 14.0),
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  maxLines: 1, // Limit to one line
                ),
              );
            }
            return Container(); // Empty container for extra items
          }
        },
      );
    } ),
    ),
    );
  }
}


