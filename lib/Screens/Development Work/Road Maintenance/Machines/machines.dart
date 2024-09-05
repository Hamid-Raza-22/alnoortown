import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/RoadMaintenaceViewModel/machine_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../Models/DevelopmentsWorksModels/RoadMaintenanceModels/machine_model.dart';
import 'MachinesSummary.dart';

class Machines extends StatefulWidget {
  const Machines({super.key});

  @override
  MachinesState createState() => MachinesState();
}

class MachinesState extends State<Machines> {
  MachineViewModel machineViewModel = Get.put(MachineViewModel());
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
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  final List<String> streets = ["Street 1", "Street 2", "Street 3", "Street 4", "Street 5", "Street 6", "Street 7"];

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
                final savedData = await machineViewModel.fetchAllMachine();

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
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'Machines',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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
            buildBlockStreetRow(),
            const SizedBox(height: 16),
            const Text(
              "Machine",
              style: TextStyle(
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

                  await machineViewModel.addMachine(MachineModel(
                    id: machineId,
                    blockNo: selectedBlock,
                    streetNo: selectedStreet,
                    machine: selectedMachine,
                    timeIn: clockInTime,
                    timeOut: clockOutTime,
                    date: _getFormattedDate(),
                    time: _getFormattedTime(),
                  ));

                  await machineViewModel.fetchAllMachine();

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
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Color(0xFFC69840)),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget buildBlockStreetRow() {
    return Row(
      children: [
        Expanded(
          child: buildDropdownField("Block No.", "selectedBlock", blocks),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: buildDropdownField("Street No.", "selectedStreet", streets),
        ),
      ],
    );
  }

  Widget buildDropdownField(String title, String key, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC69840)),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: containerData[key],
          items: items.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              containerData[key] = value;
            });
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC69840)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
      ],
    );
  }

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
          label: const Text('Time In', style: TextStyle(color: Color(0xFFC69840))),
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
          label: const Text('Time Out', style: TextStyle(color: Color(0xFFC69840))),
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
