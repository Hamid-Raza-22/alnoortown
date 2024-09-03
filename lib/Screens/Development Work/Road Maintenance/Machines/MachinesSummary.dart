import 'package:flutter/material.dart';

class MachinesSummary extends StatelessWidget {

  final List<Map<String, dynamic>> machineDataList = [
    {"blockNo": "Block A", "streetNo": "Street 1", "machine": "Excavator", "dateTime": "01 Sep 2024 | 10:00 AM"},
    {"blockNo": "Block B", "streetNo": "Street 2", "machine": "Bulldozer", "dateTime": "01 Sep 2024 | 11:00 AM"},
    {"blockNo": "Block C", "streetNo": "Street 3", "machine": "Crane", "dateTime": "01 Sep 2024 | 12:00 PM"},
    {"blockNo": "Block D", "streetNo": "Street 4", "machine": "Loader", "dateTime": "01 Sep 2024 | 01:00 PM"},
  ];

   MachinesSummary({super.key});

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
        title: const Text(
          'Machines Summary',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            childAspectRatio: 2.0,
          ),
          itemCount: machineDataList.length * 4 + 4,
          itemBuilder: (context, index) {
            if (index < 4) {
              // Header Row
              return Container(
                color: const Color(0xFFC69840),
                alignment: Alignment.center,
                child: Text(
                  ['Block No.', 'Street No.', 'Machine', 'Date & Time'][index],
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              );
            } else {
              final entryIndex = (index - 4) ~/ 4;
              final column = (index - 4) % 4;

              if (entryIndex < machineDataList.length) {
                final entry = machineDataList[entryIndex];
                final data = [
                  entry['blockNo'] ?? 'N/A',
                  entry['streetNo'] ?? 'N/A',
                  entry['machine'] ?? 'N/A',
                  entry['dateTime'] ?? 'N/A',
                ];

                return GestureDetector(
                  onTap: () {
                    // Add more detailed info or actions if necessary
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: column % 2 == 0 ? Colors.white : const Color(0xFFEFEFEF),
                    alignment: Alignment.center,
                    child: Text(
                      data[column],
                      style: const TextStyle(fontSize: 12.0),
                      overflow: TextOverflow.ellipsis, // Handle overflow
                      maxLines: 1, // Limit to one line
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
  }
}
