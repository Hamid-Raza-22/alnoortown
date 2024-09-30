import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../ViewModels/BuildingWorkViewModel/RoadsSignBoardsViewModel/roads_sign_boards_view_model.dart';

class RoadSignBoardSummary extends StatelessWidget {
  final RoadsSignBoardsViewModel roadsSignBoardsViewModel = Get.put(RoadsSignBoardsViewModel());

  RoadSignBoardSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

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
          'road_sign_board_summary',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: roadsSignBoardsViewModel.allRoadsSignBoard.isEmpty
          ? const Center(child: Text('No data available', style: TextStyle(fontSize: 18)))
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: mediaQuery.size.width * 1.5,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8, // We have 8 columns now
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                  childAspectRatio: 2.0,
                ),
                itemCount: roadsSignBoardsViewModel.allRoadsSignBoard.length * 8 + 8,
                itemBuilder: (context, index) {
                  // Header row
                  if (index < 8) {
                    return Container(
                      color: const Color(0xFFC69840),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        ['block_no', 'road_no', 'from_plot', 'to_plot', 'road_side', 'status', 'date', 'time'][index],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    );
                  } else {
                    // Data rows
                    final entryIndex = (index - 8) ~/ 8;
                    if (entryIndex < roadsSignBoardsViewModel.allRoadsSignBoard.length) {
                      final entry = roadsSignBoardsViewModel.allRoadsSignBoard[entryIndex];
                      final data = [
                        entry.block_no ?? 'N/A',
                        entry.road_no ?? 'N/A',
                        entry.from_plot_no ?? 'N/A',
                        entry.to_plot_no ?? 'N/A',
                        entry.road_side ?? 'N/A',
                        entry.comp_status ?? 'N/A',
                        entry.date ?? 'N/A',
                        entry.time ?? 'N/A'
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
                                  'Details | ${data[0]}',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      Text('Road No: ${data[1]}', style: const TextStyle(fontSize: 16)),
                                      Text('From Plot: ${data[2]}', style: const TextStyle(fontSize: 16)),
                                      Text('To Plot: ${data[3]}', style: const TextStyle(fontSize: 16)),
                                      Text('Road Side: ${data[4]}', style: const TextStyle(fontSize: 16)),
                                      Text('Status: ${data[5]}', style: const TextStyle(fontSize: 16)),
                                      Text('Date: ${data[6]}', style: const TextStyle(fontSize: 16)),
                                      Text('Time: ${data[7]}', style: const TextStyle(fontSize: 16)),
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
                                    child: const Text('close'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          color: index % 8 == 0 ? Colors.white : const Color(0xFFEFEFEF),
                          alignment: Alignment.center,
                          child: Text(
                            data[index % 8],
                            style: const TextStyle(fontSize: 11.0),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      );
                    }
                    return Container();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
