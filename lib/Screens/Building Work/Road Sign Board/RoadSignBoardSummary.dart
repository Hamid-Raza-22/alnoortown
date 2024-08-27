import 'package:flutter/material.dart';

class RoadSignBoardSummary extends StatelessWidget {
  final List<Map<String, dynamic>> containerDataList;

  const RoadSignBoardSummary({super.key, required this.containerDataList});

  @override
  Widget build(BuildContext context) {
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
          'Road Sign Board Summary',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: containerDataList.isEmpty
          ? Center(child: Text('No data available', style: TextStyle(fontSize: 18)))
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Block')),
            DataColumn(label: Text('Road No')),
            DataColumn(label: Text('From Plot')),
            DataColumn(label: Text('To Plot')),
            DataColumn(label: Text('Road Side')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Date')),
            DataColumn(label: Text('Time')),
          ],
          rows: containerDataList.map((entry) {
            final timestamp = entry['timestamp'];
            final dateTime = timestamp != null && timestamp.isNotEmpty
                ? DateTime.parse(timestamp)
                : null;
            final date = dateTime != null ? '${dateTime.day}/${dateTime.month}/${dateTime.year}' : 'N/A';
            final time = dateTime != null ? '${dateTime.hour}:${dateTime.minute}' : 'N/A';

            return DataRow(
              cells: [
                DataCell(Text('${entry['block'] ?? 'N/A'}')),
                DataCell(Text('${entry['roadNo'] ?? 'N/A'}')),
                DataCell(Text('${entry['fromPlot'] ?? 'N/A'}')),
                DataCell(Text('${entry['toPlot'] ?? 'N/A'}')),
                DataCell(Text('${entry['roadSide'] ?? 'N/A'}')),
                DataCell(Text('${entry['status'] ?? 'N/A'}')),
                DataCell(Text(date)),
                DataCell(Text(time)),
              ],
              onSelectChanged: (selected) {
                if (selected ?? false) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        title: Text(
                          'Details | ${entry['block'] ?? 'N/A'}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text('Road No: ${entry['roadNo'] ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                              Text('From Plot: ${entry['fromPlot'] ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                              Text('To Plot: ${entry['toPlot'] ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                              Text('Road Side: ${entry['roadSide'] ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                              Text('Status: ${entry['status'] ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                              Text('Timestamp: ${formatTimestamp(entry['timestamp'])}', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFFC69840),
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
            );
          }).toList(),
        ),
      ),
    );
  }

  String formatTimestamp(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) {
      return 'N/A';
    }
    final dateTime = DateTime.parse(timestamp);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
  }
}
