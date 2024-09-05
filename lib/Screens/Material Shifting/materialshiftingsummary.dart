import 'package:flutter/material.dart';

class MaterialShiftingSummaryPage extends StatelessWidget {
  final List<Map<String, String>> machineDataList = [
    {"fromBlock": "Block A", "toBlock": "Block B", "numOfShift": "5"},
    {"fromBlock": "Block C", "toBlock": "Block D", "numOfShift": "3"},
    {"fromBlock": "Block E", "toBlock": "Block F", "numOfShift": "7"},
    {"fromBlock": "Block G", "toBlock": "Block H", "numOfShift": "2"},
  ];

  MaterialShiftingSummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Shifting Summary'),
        backgroundColor: const Color(0xFFC69840),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns for headers + data
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 3.0, // Adjust aspect ratio for better visibility
          ),
          itemCount: machineDataList.length * 3 + 3, // Number of data items + headers
          itemBuilder: (context, index) {
            if (index < 3) {
              // Header Row
              return Container(
                color: const Color(0xFFC69840),
                alignment: Alignment.center,
                child: Text(
                  ['From Block', 'To Block', 'Shifts'][index],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14.0),
                ),
              );
            } else {
              final entryIndex = (index - 3) ~/ 3;
              final columnIndex = (index - 3) % 3;

              if (entryIndex < machineDataList.length) {
                final entry = machineDataList[entryIndex];
                final data = [
                  entry['fromBlock'] ?? 'N/A',
                  entry['toBlock'] ?? 'N/A',
                  entry['numOfShift'] ?? 'N/A',
                ];

                return Container(
                  padding: const EdgeInsets.all(8.0),
                  color: columnIndex % 2 == 0 ? Colors.white : const Color(0xFFEFEFEF),
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
        ),
      ),
    );
  }
}


