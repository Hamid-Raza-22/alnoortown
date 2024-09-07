import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NewMaterialSummary extends StatelessWidget {
  final List<Map<String, dynamic>> summaryDataList = [
    {
      "sand": 5,
      "soil": 10,
      "base": 7,
      "subBase": 3,
      "waterBound": 8,
      "otherMaterial": "Gravel",
      "Quantity": 20,
    },
    {
      "sand": 6,
      "soil": 12,
      "base": 8,
      "subBase": 4,
      "waterBound": 9,
      "otherMaterial": "Sandstone",
      "Quantity": 15,
    },
  ];

  NewMaterialSummary({super.key});

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
        title: Text(
          'New Material Summary'.tr(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              // Header row
              Row(
                children: [
                  buildHeaderCell('Sand'),
                  buildHeaderCell('Soil'),
                  buildHeaderCell('Base'),
                  buildHeaderCell('Sub Base'),
                  buildHeaderCell('Water Bound'),
                  buildHeaderCell('Other Material'),
                  buildHeaderCell('Other Quantity'),
                ],
              ),
              const SizedBox(height: 10),
              // Data rows
              ...summaryDataList.map((entry) {
                return Row(
                  children: [
                    buildDataCell(entry['sand']?.toString() ?? 'N/A'),
                    buildDataCell(entry['soil']?.toString() ?? 'N/A'),
                    buildDataCell(entry['base']?.toString() ?? 'N/A'),
                    buildDataCell(entry['subBase']?.toString() ?? 'N/A'),
                    buildDataCell(entry['waterBound']?.toString() ?? 'N/A'),
                    buildDataCell(entry['otherMaterial'] ?? 'N/A'),
                    buildDataCell(entry['Quantity']?.toString() ?? 'N/A'),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeaderCell(String text) {
    return Container(
      width: 120, // Adjust as needed
      padding: const EdgeInsets.all(8.0),
      color: const Color(0xFFC69840),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget buildDataCell(String text) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 12.0),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
