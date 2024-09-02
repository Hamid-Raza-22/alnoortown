import 'package:flutter/material.dart';

class WaterTankerSummary extends StatelessWidget {
  final List<Map<String, dynamic>> tankerDataList;

  const WaterTankerSummary({super.key})
      : tankerDataList = const [
    {"selectedBlock": "Block A", "selectedStreet": "Street 1", "selectedTankers": 3},
    {"selectedBlock": "Block B", "selectedStreet": "Street 2", "selectedTankers": 2},
    {"selectedBlock": "Block C", "selectedStreet": "Street 3", "selectedTankers": 5},
    {"selectedBlock": "Block D", "selectedStreet": "Street 4", "selectedTankers": 1},
  ];

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
          'Water Tanker Summary',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns for Block No., Street No., and No. of Tankers
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 1.0,
            childAspectRatio: 3.0, // Adjust for better width
          ),
          itemCount: tankerDataList.length * 3 + 3, // Additional 3 for headings
          itemBuilder: (context, index) {
            if (index < 3) {
              // Header Row
              return Container(
                color: const Color(0xFFC69840),
                alignment: Alignment.center,
                child: Text(
                  ['Block No.', 'Street No.', 'No. of Tankers'][index],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              );
            } else {
              final entryIndex = (index - 3) ~/ 3;
              final column = (index - 3) % 3;

              if (entryIndex < tankerDataList.length) {
                final entry = tankerDataList[entryIndex];
                final data = [
                  entry['selectedBlock'] ?? 'N/A',
                  entry['selectedStreet'] ?? 'N/A',
                  entry['selectedTankers']?.toString() ?? 'N/A',
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
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                                child: const Text('Close'),
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
                      overflow: TextOverflow.ellipsis, // Handle overflow
                      maxLines: 1, // Limit to one line
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
  }
}
