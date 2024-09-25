import 'package:al_noor_town/ViewModels/MaterialShiftingViewModel/material_shifting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;

class MaterialShiftingSummaryPage extends StatelessWidget {
  final MaterialShiftingViewModel materialShiftingViewModel= Get.put(MaterialShiftingViewModel());
  final List<Map<String, String>> machineDataList = [
    {"from_block": "Block A", "to_block": "Block B", "no_of_shift": "5"},
    {"from_block": "Block C", "to_block": "Block D", "no_of_shift": "3"},
    {"from_block": "Block E", "to_block": "Block F", "no_of_shift": "7"},
    {"from_block": "Block G", "to_block": "Block H", "no_of_shift": "2"},
  ];

  MaterialShiftingSummaryPage({super.key});

  @override
  Widget build(BuildContext context) {

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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/nodata.png', // Replace with your image path
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No data available',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
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
                    entry.from_block ?? 'N/A',
                    entry.to_block ?? 'N/A',
                    entry.no_of_shift ?? 'N/A',
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
        }),
      ),
    );
  }
}

