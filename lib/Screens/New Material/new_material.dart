import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/NewMaterialModels/new_material_model.dart';
import 'package:al_noor_town/ViewModels/NewMaterialViewModel/new_material_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NewMaterial extends StatefulWidget {
  const NewMaterial({Key? key}) : super(key: key);

  @override
  _NewMaterialState createState() => _NewMaterialState();
}

class _NewMaterialState extends State<NewMaterial> {
  NewMaterialViewModel newMaterialViewModel=Get.put(NewMaterialViewModel());
  DBHelper dbHelper = DBHelper();
  int? brickId;
  List<Map<String, dynamic>> containerDataList = [];

  @override
  void initState() {
    super.initState();
    containerDataList.add(createInitialContainerData());
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "sand": 0,
      "soil": 0,
      "base": 0,
      "subBase": 0,
      "waterBound": 0,
      "otherMaterial": "",
      "otherMaterialValue": 0,
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
                    image: AssetImage('assets/images/dumper.png'),
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
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'New Material',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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
                elevation: 0,
                child: const Icon(Icons.add, color: Color(0xFFC69840), size: 36.0),
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
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabelsAndFields(index, containerData, ["Sand", "Soil"]),
            const SizedBox(height: 16),
            buildLabelsAndFields(index, containerData, ["Base", "Sub Base"]),
            const SizedBox(height: 16),
            buildLabelsAndFields(index, containerData, ["Water Bound"]),
            const SizedBox(height: 16),
            buildOtherMaterialField(index, containerData),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final sand = containerData["sand"];
                  final soil = containerData["soil"];
                  final base = containerData["base"];
                  final subBase = containerData["subBase"];
                  final waterBound = containerData["waterBound"];
                  final otherMaterial = containerData["otherMaterial"];
                  final otherMaterialValue = containerData["otherMaterialValue"];
                  await newMaterialViewModel.addNewMaterial(
                      NewMaterialModel(
                        sand: sand,

                        subBase: subBase,
                        base: base,
                        waterBound: waterBound,
                        otherMaterial: otherMaterial,

                      ));





                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Data Submitted for index $index: $containerData',
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

  Widget buildLabelsAndFields(int index, Map<String, dynamic> containerData, List<String> labels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: labels.map((label) {
        String fieldName = getFieldName(label);
        int value = containerData[fieldName] ?? 0;
        return Expanded(
          child: buildStepperField(label, containerData, fieldName, value),
        );
      }).toList(),
    );
  }

  Widget buildOtherMaterialField(int index, Map<String, dynamic> containerData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Other Material",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFC69840)),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      containerData["otherMaterial"] = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Other Material',
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  style: const TextStyle(color: Color(0xFFC69840)),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Color(0xFFC69840)),
                    onPressed: () {
                      setState(() {
                        if (containerData["otherMaterialValue"] > 0) {
                          containerData["otherMaterialValue"]--;
                        }
                      });
                    },
                  ),
                  Text(
                    '${containerData["otherMaterialValue"] ?? 0}',
                    style: const TextStyle(fontSize: 16, color: Color(0xFFC69840)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Color(0xFFC69840)),
                    onPressed: () {
                      setState(() {
                        containerData["otherMaterialValue"]++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getFieldName(String label) {
    switch (label) {
      case "Sub Base":
        return "subBase";
      case "Water Bound":
        return "waterBound";
      case "Other Material":
        return "otherMaterial";
      default:
        return label.toLowerCase();
    }
  }

  Widget buildStepperField(String label, Map<String, dynamic> containerData, String fieldName, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFC69840)),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: Color(0xFFC69840)),
                onPressed: () {
                  setState(() {
                    if (containerData[fieldName] > 0) {
                      containerData[fieldName]--;
                    }
                  });
                },
              ),
              Container(
                width: 35,
                child: TextField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  controller: TextEditingController(text: value.toString()),
                  onChanged: (newValue) {
                    setState(() {
                      containerData[fieldName] = int.tryParse(newValue) ?? value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 14, color: Color(0xFFC69840)), // Reduced font size
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Color(0xFFC69840)),
                onPressed: () {
                  setState(() {
                    containerData[fieldName]++;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }


}
