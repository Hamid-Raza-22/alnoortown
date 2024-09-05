import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CanopyColoumnsummary extends StatelessWidget {
  final List<Map<String, dynamic>> containerDataList;

    CanopyColoumnsummary({super.key, required this.containerDataList});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:   Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:   Text(
          'Main Gate Plaster Summary',
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
                color: Color(0xFFC69840),
                alignment: Alignment.center,
                child: Text(
                  ['block_no'.tr(), 'work_status'.tr(), 'date'.tr(), 'time'.tr()][index],
                  style:   TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              );
            } else {
              final entryIndex = (index - 4) ~/ 4;
              if (entryIndex < containerDataList.length) {
                final entry = containerDataList[entryIndex];
                final dateTime = DateTime.parse(entry['timestamp']);
                final data = [
                  entry['selectedBlock'] ?? 'N/A',
                  entry['workStatus'] ?? 'N/A',
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
                                foregroundColor: Colors.white, backgroundColor:  Color(0xFFC69840),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child:   Text('close'.tr()),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Container(
                    padding:   EdgeInsets.all(8.0),
                    color: index % 4 == 0 ? Colors.white : Color(0xFFEFEFEF),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            data[index % 4],
                            style:   TextStyle(fontSize: 12.0),
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