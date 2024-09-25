import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsSignBoardsViewModel/roads_sign_boards_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;


class RoadSignBoardSummary extends StatelessWidget {
RoadsSignBoardsViewModel roadsSignBoardsViewModel = Get.put(RoadsSignBoardsViewModel());
    RoadSignBoardSummary({super.key});

  @override
  Widget build(BuildContext context) {
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
          'road_sign_board_summary'.tr(),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: roadsSignBoardsViewModel.allRoadsSignBoard.isEmpty
          ?   Center(child: Text('No data available', style: TextStyle(fontSize: 18)))
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child:
        DataTable(
          columns:   [
            DataColumn(label: Text('block_no'.tr())),
            DataColumn(label: Text('road_no'.tr())),
            DataColumn(label: Text('from_plot'.tr())),
            DataColumn(label: Text('to_plot'.tr())),
            DataColumn(label: Text('road_side'.tr())),
            DataColumn(label: Text('status'.tr())),
            DataColumn(label: Text('date'.tr())),
            DataColumn(label: Text('time'.tr())),
          ],
          rows: roadsSignBoardsViewModel.allRoadsSignBoard.map((entry) {
            // final timestamp = entry.time;
            // final dateTime = timestamp != null && timestamp.isNotEmpty
            //     ? DateTime.parse(timestamp)
            //     : null;
            // final date = dateTime != null ? '${dateTime.day}/${dateTime.month}/${dateTime.year}' : 'N/A';
            // final time = dateTime != null ? '${dateTime.hour}:${dateTime.minute}' : 'N/A';

            return DataRow(
              cells: [
                DataCell(Text(entry.block_no ?? 'N/A')),
                DataCell(Text(entry.road_no?? 'N/A')),
                DataCell(Text(entry.from_plot_no?? 'N/A')),
                DataCell(Text(entry.to_plot_no?? 'N/A')),
                DataCell(Text(entry.road_side ?? 'N/A')),
                DataCell(Text(entry.comp_status ?? 'N/A')),
                DataCell(Text(entry.date ?? 'N/A')),
                DataCell(Text(entry.time ?? 'N/A')),
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
                          'Details | ${entry.block_no?? 'N/A'}',
                          style:   TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text('road_no ${entry.road_no?? 'N/A'}', style:   TextStyle(fontSize: 16)),
                              Text('From Plot: ${entry.from_plot_no ?? 'N/A'}', style:   TextStyle(fontSize: 16)),
                              Text('To Plot:' '${entry.to_plot_no?? 'N/A'}', style:   TextStyle(fontSize: 16)),
                              Text('Road Side: ${entry.road_side?? 'N/A'}', style:   TextStyle(fontSize: 16)),
                              Text('Status: ${entry.comp_status ?? 'N/A'}', style:   TextStyle(fontSize: 16)),
                              Text('Date: ${entry.date}', style:   TextStyle(fontSize: 16)),
                              Text('Time: ${entry.time}', style:   TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor:   Color(0xFFC69840),
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
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

}
