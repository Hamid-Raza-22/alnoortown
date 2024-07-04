import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Machines extends StatefulWidget {
  const Machines({super.key});

  @override
  _MachinesState createState() => _MachinesState();
}

class _MachinesState extends State<Machines> {
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

  List<Map<String, dynamic>> containerDataList = [];
  String? otherMachine;
  List<String> userAddedMachines = [];

  @override
  void initState() {
    super.initState();
    containerDataList.add(createInitialContainerData());
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedMachine": null,
      "selectedBlock": null,
      "selectedStreet": null,
      "clockInTime": "00:00 AM",
      "clockOutTime": "00:00 AM",
    };
  }

  String getCurrentDate() {
    final now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(220.0),
        child: AppBar(
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/machinespage.gif',
              fit: BoxFit.fitHeight,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: Text(
                  getCurrentDate(),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            ...containerDataList.asMap().entries.map((entry) {
              int index = entry.key;
              return buildContainer(index);
            }),
            const SizedBox(height: 16),
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    containerDataList.add(createInitialContainerData());
                  });
                },
                backgroundColor: Colors.transparent,
                elevation: 0, // No shadow
                child: const Icon(Icons.add, color: Color(0xFFC69840), size: 36.0), // Increase size of the icon
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildContainer(int index) {
    var containerData = containerDataList[index];
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
    buildBlockStreetRow(containerData),
    const SizedBox(height: 16),
    const Text(
    "Machine",
    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
    ),
    const SizedBox(height: 8),
    DropdownButtonFormField<String>(
    value: containerData["selectedMachine"],
    items: [...machines, ...userAddedMachines].map((machine) {
    int idx = machines.indexOf(machine);
    if (idx == -1) {
    return DropdownMenuItem(
    value: machine,
    child: Row(
    children: [
    const Icon(Icons.add, color: Color(0xFFC69840)),
    const SizedBox(width: 8),
    Text(machine),
    ],
    ),
    );
    } else {
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
    }
    }).toList(),
    onChanged: (value) {
    setState(() {
    containerData["selectedMachine"] = value;
    if (value == "Other") {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    String newMachineName = '';
    return Dialog(
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10.0),
    color: Colors.white,
    ),
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    const Padding(
    padding: EdgeInsets.all(16.0),
    child: Text(
    'Other Machines',
    style: TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Color(0xFFC69840),
    ),
    ),
    ),
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    child: TextField(
    onChanged: (text) {
    newMachineName = text;
    },
    decoration: InputDecoration(
    hintText: "Enter machine name",
    border: OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFC69840)),
    borderRadius: BorderRadius.circular(8.0),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    ),
    ),
    ),
    const SizedBox(height: 16.0),
    Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
    TextButton(
    child: const Text(
    "Cancel",
    style: TextStyle(
    color: Color(0xFFC69840),
    fontSize: 16.0,
    ),
    ),
    onPressed: () {
    Navigator.of(context).pop();
    },
    ),
    TextButton(
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFC69840)),
    padding: MaterialStateProperty.all<EdgeInsets>(
    const EdgeInsets.symmetric(horizontal: 16.0),
    ),
    ),
    onPressed: () {
    setState(() {
    if (newMachineName.isNotEmpty) {
    userAddedMachines.add(newMachineName);
    containerData["selectedMachine"] = newMachineName;
    }
    Navigator.of(context).pop();
    });
    },
    child: const Text(
    "OK",
    style: TextStyle(
    color: Colors.white,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    const SizedBox(width: 16.0),
    ],
    ),
    ],
    ),
    ),
    );
    },
    );
    }
    });
    },
    decoration: const InputDecoration(
    border: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFC69840)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 8),
    ),
    ),
    const SizedBox(height: 20),
    buildTimeButtons(containerData),
    const SizedBox(height: 20),
    Center(
    child: ElevatedButton(
    onPressed: () {
    final selectedMachine = containerData["selectedMachine"];
    final selectedBlock = containerData["selectedBlock"];
    final selectedStreet = containerData["selectedStreet"];
    final clockInTime = containerData["clockInTime"];
    final clockOutTime = containerData["clockOutTime"];

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
    child: const Text('Submit', style: TextStyle(color: Color(0xFFC69840))),
    ),
    ),
    const SizedBox(height: 10),
    Center(
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    '${containerData["clockInTime"]}',
    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
    ),
    Text(
    '${containerData["clockOutTime"]}',
    style: const TextStyle(fontSize: 14, fontWeight : FontWeight.bold, color: Color(0xFFC69840)),
    ),
    ],
    ),
    )
    ],
    ),
    ),
    );
  }

  Widget buildBlockStreetRow(Map<String, dynamic> containerData) {
    return Row(
      children: [
        Expanded(
          child: buildDropdownField(
              "Block No.", containerData, "selectedBlock", blocks
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: buildDropdownField(
              "Street No.", containerData, "selectedStreet", streets
          ),
        ),
      ],
    );
  }

  Widget buildDropdownField(String title, Map<String, dynamic> containerData, String key, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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

  Widget buildTimeButtons(Map<String, dynamic> containerData) {
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
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            textStyle: const TextStyle(fontSize: 12),
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
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
            textStyle: const TextStyle(fontSize: 12),
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
    String period = now.hour >= 12 ? 'PM' : 'AM';
    int hour = now.hour % 12;
    hour = hour == 0 ? 12 : hour;
    return "${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} $period";
  }
}
