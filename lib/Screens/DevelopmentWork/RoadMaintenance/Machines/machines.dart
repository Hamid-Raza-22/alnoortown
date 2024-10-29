import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/RoadMaintenaceViewModel/machine_view_model.dart';
import 'package:al_noor_town/ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import '../../../../Models/DevelopmentsWorksModels/RoadMaintenanceModels/machine_model.dart';
import '../../../../ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import '../../../../Widgets/custom_dropdown_widgets.dart';
import 'MachinesSummary.dart';

class Machines extends StatefulWidget {
  Machines({super.key});

  @override
  MachinesState createState() => MachinesState();
}

class MachinesState extends State<Machines> {
  MachineViewModel machineViewModel = Get.put(MachineViewModel());
  BlockDetailsViewModel blockDetailsViewModel = Get.put(BlockDetailsViewModel());
  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());
  DBHelper dbHelper = DBHelper();
  int? machineId;
  final List<String> machines = [
    "Excavator", "Bulldozer", "Crane", "Loader", "Dump Truck", "Forklift", "Paver", "Other"
  ];
  final List<Icon> machineIcons = [
    const Icon(Icons.construction, color: Color(0xFFC69840)),
    const Icon(Icons.agriculture, color: Color(0xFFC69840)),
    const Icon(Icons.account_balance, color: Color(0xFFC69840)),
    const Icon(Icons.local_shipping, color: Color(0xFFC69840)),
    const Icon(Icons.fire_truck, color: Color(0xFFC69840)),
    const Icon(Icons.precision_manufacturing, color: Color(0xFFC69840)),
    const Icon(Icons.add_box, color: Color(0xFFC69840)),
    const Icon(Icons.edit, color: Color(0xFFC69840)),
  ];



  Map<String, dynamic> containerData = {
    "selectedMachine": null,
    "selectedBlock": null,
    "selectedStreet": null,
    "clockInTime": "00:00 AM",
    "clockOutTime": "00:00 AM",
  };

  String _getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('d MMM yyyy');
    return formatter.format(now);
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    final formatter = DateFormat('h:mm a');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: AppBar(
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/machin.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.summarize, color: Color(0xFFC69840),),
              onPressed: () async {
                final savedData = await machineViewModel.fetchAllMachines();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MachinesSummary(
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 1),
             Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'machine'.tr(),
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
              ),
            ),
            buildContainer(),
          ],
        ),
      ),
    );
  }

  Widget buildContainer() {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockStreetRow(containerData, roadDetailsViewModel),
            const SizedBox(height: 16),
             Text(
              "machine".tr(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC69840),
              ),
            ),
            const SizedBox(height: 8),
            buildMachineDropdown(),
            const SizedBox(height: 20),
            buildTimeButtons(),


            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final selectedMachine = containerData["selectedMachine"];
                  final selectedBlock = containerData["selectedBlock"];
                  final selectedStreet = containerData["selectedStreet"];
                  final clockInTime = containerData["clockInTime"];
                  final clockOutTime = containerData["clockOutTime"];

                  // Create a MachineModel instance
                  final machineModel = MachineModel(
                    id: machineId,
                    block_no: selectedBlock,
                    street_no: selectedStreet,
                    machine: selectedMachine,
                    time_in: clockInTime,
                    time_out: clockOutTime,
                    date: _getFormattedDate(),
                    time: _getFormattedTime(),
                    user_id: userId
                  );

                  try {
                    // Step 1: Add machine to the local database
                    await machineViewModel.addMachine(machineModel);
                    print('Machine added to local database');

                    // Step 2: Post data from the database to the API
                    await machineViewModel.postDataFromDatabaseToAPI();
                  } catch (e) {
                    print('Error posting machine data: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error posting to API: $e'),
                      ),
                    );
                  }

                  // Clear fields after submission
                  setState(() {
                    containerData = {
                      "selectedMachine": null,
                      "selectedBlock": null,
                      "selectedStreet": null,
                      "clockInTime": "00:00 AM",
                      "clockOutTime": "00:00 AM",
                    };
                  });

                  // Show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: $selectedMachine, $selectedBlock, $selectedStreet, Time In: $clockInTime, Time Out: $clockOutTime',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F4F6),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 14),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  'submit'.tr(),
                  style: const TextStyle(color: Color(0xFFC69840)),
                ),
              ),

            )

          ],
        ),
      ),
    );
  }

  // Widget buildDropdownField(String title, Map<String, dynamic> containerData, String key, List<String> items) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
  //       ),
  //       SizedBox(height: 8),
  //       DropdownSearch<String>(
  //         items: items,
  //         selectedItem: containerData[key],
  //         dropdownDecoratorProps: DropDownDecoratorProps(
  //           dropdownSearchDecoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderSide: const BorderSide(color: Color(0xFF4A4A4A)),
  //               borderRadius: BorderRadius.circular(8), // Slightly larger border radius
  //             ),
  //             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // More padding for a cleaner look
  //           ),
  //         ),
  //         popupProps: PopupProps.menu(
  //           showSearchBox: true, // Enables the search feature
  //           itemBuilder: (context, item, isSelected) {
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //               child: Text(
  //                 item,
  //                 style: const TextStyle(fontSize: 11), // Slightly larger font for dropdown items
  //               ),
  //             );
  //           },
  //         ),
  //         onChanged: (value) {
  //           setState(() {
  //             containerData[key] = value;
  //           });
  //         },
  //       ),
  //     ],
  //   );
  // }
  // Widget buildDropdownField(
  //     String title,
  //     Map<String, dynamic> containerData,
  //     String key,
  //     List<String> items,
  //     {Function(String)? onChanged} // Optional callback parameter
  //     ) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         title,
  //         style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
  //       ),
  //       SizedBox(height: 8),
  //       DropdownSearch<String>(
  //         items: items,
  //         selectedItem: containerData[key],
  //         dropdownDecoratorProps: DropDownDecoratorProps(
  //           dropdownSearchDecoration: InputDecoration(
  //             border: OutlineInputBorder(
  //               borderSide: const BorderSide(color: Color(0xFF4A4A4A)),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //           ),
  //         ),
  //         popupProps: PopupProps.bottomSheet(
  //           showSearchBox: true,
  //           itemBuilder: (context, item, isSelected) {
  //             return Padding(
  //               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  //               child: Text(
  //                 item,
  //                 style: const TextStyle(fontSize: 14),
  //               ),
  //             );
  //           },
  //         ),
  //         onChanged: (value) {
  //           containerData[key] = value;
  //           if (onChanged != null && value != null) {
  //             onChanged(value); // Trigger the callback if provided
  //           }
  //         },
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget buildBlockStreetRow(Map<String, dynamic> containerData) {
  //   return Obx(() {
  //     // List of unique blocks from all road details
  //     final List<String> blocks = roadDetailsViewModel.allRoadDetails
  //         .map((detail) => detail.block.toString())
  //         .toSet()
  //         .toList();
  //
  //     return Row(
  //       children: [
  //         Expanded(
  //           child: buildDropdownField(
  //             "block_no".tr(),
  //             containerData,
  //             "selectedBlock",
  //             blocks,
  //             onChanged: (selectedBlock) {
  //               // Update streets based on the selected block
  //               roadDetailsViewModel.updateFilteredStreets(selectedBlock);
  //             },
  //           ),
  //         ),
  //         const SizedBox(width: 16),
  //         Expanded(
  //           child: buildDropdownField(
  //             "street_no".tr(),
  //             containerData,
  //             "selectedStreet",
  //             roadDetailsViewModel.filteredStreets, // Filtered streets
  //           )),
  //       ],
  //     );
  //   });
  // }

  // Widget buildBlockStreetRow(Map<String, dynamic> containerData) {
  //   return Obx(() {
  //     // Dynamically get the blocks list from the BlockDetailsViewModel
  //     final List<String> blocks = roadDetailsViewModel.allRoadDetails
  //         .map((blockDetail) => blockDetail.block.toString())
  //         .toSet()
  //         .toList();
  //     // Dynamically get the streets list from the BlockDetailsViewModel
  //     final List<String> streets = roadDetailsViewModel.allRoadDetails
  //         .map((streetDetail) => streetDetail.street.toString())
  //         .toSet()
  //         .toList();
  //
  //     return Row(
  //       children: [
  //         Expanded(
  //           child: buildDropdownField(
  //               "block_no".tr(),containerData,  "selectedBlock", blocks),
  //         ),
  //         const SizedBox(width: 16),
  //         Expanded(
  //           child: buildDropdownField(
  //               "street_no".tr(),containerData,  "selectedStreet", streets),
  //         ),
  //       ],
  //     );
  //   });
  // }


  Widget buildMachineDropdown() {
    return DropdownButtonFormField<String>(
      value: containerData["selectedMachine"],
      items: machines.map((machine) {
        int idx = machines.indexOf(machine);
        return DropdownMenuItem(
          value: machine,
          child: Row(
            children: [
              machineIcons[idx],
              const SizedBox(width: 8),
              Text(machine),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          containerData["selectedMachine"] = value;
        });
      },
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFC69840)),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8),
      ),
    );
  }

  Widget buildTimeButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              containerData["clockInTime"] = getCurrentTime();
            });
          },
          icon: const Icon(Icons.access_time, color: Color(0xFFC69840)),
          label:  Text('time_in'.tr(), style: const TextStyle(color: Color(0xFFC69840))),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF3F4F6),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            textStyle: const TextStyle(fontSize: 14),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              containerData["clockOutTime"] = getCurrentTime();
            });
          },
          icon: const Icon(Icons.access_time, color: Color(0xFFC69840)),
          label:  Text('time_out'.tr(), style: const TextStyle(color: Color(0xFFC69840))),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFF3F4F6),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            textStyle: const TextStyle(fontSize: 14),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
          ),
        ),
      ],
    );
  }

  String getCurrentTime() {
    final now = DateTime.now();
    final formatter = DateFormat('hh:mm a');
    return formatter.format(now);
  }
}
