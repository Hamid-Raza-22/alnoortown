import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/DevelopmentsWorksModels/RoadMaintenanceModels/tanker_model.dart';
import 'package:al_noor_town/ViewModels/DevelopmentWorksViewModel/RoadMaintenaceViewModel/tanker_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class WaterTanker extends StatefulWidget {
  const WaterTanker({super.key});

  @override
  _WaterTankerState createState() => _WaterTankerState();
}

class _WaterTankerState extends State<WaterTanker>  {
  TankerViewModel tankerViewModel=Get.put(TankerViewModel());
  DBHelper dbHelper = DBHelper();
  int? tankerId;
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"];
  final List<String> streets = ["Street 1", "Street 2", "Street 3", "Street 4", "Street 5", "Street 6", "Street 7"];
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
      "selectedTankers": null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180.0),
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
                    image: AssetImage('assets/images/truck-01.png'),
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
            const SizedBox(height: 1),
            const Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Water Tanker',
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
        containerData["selectedTankers"] != null;

    return Stack(
      children: [
        Card(
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
                const Text(
                  "No. of Tankers",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<int>(
                  value: containerData["selectedTankers"],
                  items: List.generate(10, (index) => index + 1).map((number) {
                    return DropdownMenuItem(
                      value: number,
                      child: Text(number.toString()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      containerData["selectedTankers"] = value;
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
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final selectedBlock = containerData["selectedBlock"];
                      final selectedStreet = containerData["selectedStreet"];
                      final selectedTankers = containerData["selectedTankers"];
                      {
                       await tankerViewModel.addTanker(TankerModel(
                            id: tankerId,
                            blockNo: selectedBlock,
                            streetNo: selectedStreet,
                            tankerNo: selectedTankers,



                        ));
                       await tankerViewModel.fetchAllTanker();
                       // await dbHelper.showTankerData();
                        // nameController.text = "";
                      }

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Selected: $selectedBlock, $selectedStreet, No. of Tankers: $selectedTankers',
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
        ),
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: IgnorePointer(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: WaterLoadingWidget(isFilled: isFilled),
              ),
            ),
          ),
        ),
      ],
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
}

class WaterLoadingWidget extends StatelessWidget {
  final bool isFilled;

  const WaterLoadingWidget({super.key, required this.isFilled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: WaveWidget(
        config: CustomConfig(
          gradients: [
            [Colors.blue.withOpacity(0.1), Colors.blue.withOpacity(0.1)],
            [Colors.blueAccent.withOpacity(0.2), Colors.blueAccent.withOpacity(0.2)],
            [Colors.blue.withOpacity(0.3), Colors.blue.withOpacity(0.3)],
          ],
          durations: [35000, 19440, 10800],
          heightPercentages: isFilled ? [0.30, 0.32, 0.34] : [0.0, 0.0, 0.0],
          blur: const MaskFilter.blur(BlurStyle.solid, 10),
          gradientBegin: Alignment.bottomLeft,
          gradientEnd: Alignment.topRight,
        ),
        waveAmplitude: 0,
        size: const Size(double.infinity, double.infinity),
      ),
    );
  }
}
