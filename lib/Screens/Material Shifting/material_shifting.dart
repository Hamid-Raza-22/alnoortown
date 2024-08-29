import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/MaterialShiftingModels/shifting_work_model.dart';
import 'package:al_noor_town/ViewModels/MaterialShiftingViewModel/material_shifting_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MaterialShiftingPage extends StatefulWidget {
  const MaterialShiftingPage({super.key});

  @override
  MaterialShiftingPageState createState() => MaterialShiftingPageState();
}

class MaterialShiftingPageState extends State<MaterialShiftingPage> {
  MaterialShiftingViewModel materialShiftingViewModel=Get.put(MaterialShiftingViewModel());
  DBHelper dbHelper = DBHelper();
  int? shiftId;
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  final List<String> streets = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  List<Map<String, dynamic>> containerDataList = [];

  @override
  void initState() {
    super.initState();
    containerDataList.add(createInitialContainerData());
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedBlock": null,
      "selectedStreet": null,
      "selectedShifting": 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/trackter-01.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ],
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Shifting Work',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
              ),
            ),
            ...containerDataList.asMap().entries.map((entry) {
              int index = entry.key;
              return Column(
                children: [
                  buildContainer(index),
                  const SizedBox(height: 16),
                ],
              );
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
    bool isFilled = containerData["selectedBlock"] != null &&
        containerData["selectedStreet"] != null &&
        containerData["selectedShifting"] != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockStreetRow(containerData),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "No. of Shifting",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (containerData["selectedShifting"] > 0) {
                            containerData["selectedShifting"]--;
                          }
                        });
                      },
                    ),
                    Text(
                      containerData["selectedShifting"].toString(),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          containerData["selectedShifting"]++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final fromBlock = containerData["selectedBlock"];
                  final toBlock = containerData["selectedStreet"];
                  final numOfShift = containerData["selectedShifting"];
                  {
                    await materialShiftingViewModel.addShift(ShiftingWorkModel(
                      id: shiftId,
                      fromBlock: fromBlock,
                      toBlock: toBlock,
                      numOfShift: numOfShift,


                    ));
                    await materialShiftingViewModel.fetchAllShifting();
                    // await dbHelper.showAsphaltData();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Selected: $fromBlock, $toBlock, No. of Shifting: $numOfShift',
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
                child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
              ),
            ),
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
              "From Block", containerData, "selectedBlock", blocks
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: buildDropdownField(
              "To Block", containerData, "selectedStreet", streets
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
}
