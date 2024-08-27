import 'package:flutter/material.dart';

class WaterChannelsSummary extends StatelessWidget {
  final List<Map<String, dynamic>> containerDataList;

  const WaterChannelsSummary({super.key, required this.containerDataList});

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
          'Street Roads Water Channels Summary',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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
            childAspectRatio: 2.0, // Adjusted for better width
          ),
          itemCount: containerDataList.length * 4 + 4, // Additional 4 for headings
          itemBuilder: (context, index) {
            if (index < 4) {
              // Header Row
              return Container(
                color: const Color(0xFFC69840),
                alignment: Alignment.center,
                child: Text(
                  ['Block No.', 'Work Status', 'Date', 'Time'][index],
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              );
            } else {
              final entryIndex = (index - 4) ~/ 4;
              if (entryIndex < containerDataList.length) {
                final entry = containerDataList[entryIndex];
                final dateTime = DateTime.parse(entry['timestamp']);
                final data = [
                  entry['block'] ?? 'N/A',
                  entry['status'] ?? 'N/A',
                  '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                  '${dateTime.hour}:${dateTime.minute}',
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
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: index % 4 == 0 ? Colors.white : const Color(0xFFEFEFEF),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            data[index % 4],
                            style: const TextStyle(fontSize: 12.0),
                            overflow: TextOverflow.ellipsis, // Handle overflow
                            maxLines: 1, // Limit to one line
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
  }
}