import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/NewMaterialModels/new_material_model.dart';
import 'package:al_noor_town/ViewModels/NewMaterialViewModel/new_material_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, Inst;
import 'package:intl/intl.dart';

class NewMaterial extends StatefulWidget {
    NewMaterial({Key? key}) : super(key: key);

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
  String _getFormattedDate() {
    final now = DateTime.now();
    final formatter = DateFormat('d MMM yyyy');
    return formatter.format(now);
  }  String _getFormattedTime() {
    final now = DateTime.now();
    final formatter = DateFormat('h:mm a');
    return formatter.format(now);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:   Size.fromHeight(180.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration:   BoxDecoration(
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
        padding:   EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              SizedBox(height: 20),
              Center(
              child: Text(
                'new_material'.tr(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
              ),
            ),
            ...containerDataList.asMap().entries.map((entry) {
              int index = entry.key;
              return Column(
                children: [
                  buildContainer(index),
                    SizedBox(height: 16),
                ],
              );
            }),
              SizedBox(height: 16),
            Center(
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    containerDataList.add(createInitialContainerData());
                  });
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child:   Icon(Icons.add, color: Color(0xFFC69840), size: 36.0),
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
      margin:   EdgeInsets.only(bottom: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding:   EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabelsAndFields(index, containerData, ['sand'.tr(), "Soil"]),
              SizedBox(height: 16),
            buildLabelsAndFields(index, containerData, ['base'.tr(), "Sub Base"]),
              SizedBox(height: 16),
            buildLabelsAndFields(index, containerData, ['water_bound'.tr()]),
              SizedBox(height: 16),
            buildOtherMaterialField(index, containerData),
              SizedBox(height: 20),
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
                        soil: soil,
                        subBase: subBase,
                        base: base,
                        waterBound: waterBound,
                        otherMaterial: otherMaterial,
                          date: _getFormattedDate(),
                          time: _getFormattedTime()
                      ));
                  await newMaterialViewModel.fetchAllNewMaterial();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Data Submitted for index $index: $containerData',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:   Color(0xFFF3F4F6),
                  padding:   EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle:   TextStyle(fontSize: 14),
                  shape:   RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child:   Text('submit'.tr(), style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
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
          Text(
          "Other Material",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
          SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color:   Color(0xFFC69840)),
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
                    hintText: 'other_material'.tr(),
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                    border: InputBorder.none,
                    contentPadding:   EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                  style:   TextStyle(color: Color(0xFFC69840)),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon:   Icon(Icons.remove, color: Color(0xFFC69840)),
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
                    style:   TextStyle(fontSize: 16, color: Color(0xFFC69840)),
                  ),
                  IconButton(
                    icon:   Icon(Icons.add, color: Color(0xFFC69840)),
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
          style:   TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
          SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color:   Color(0xFFC69840)),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon:   Icon(Icons.remove, color: Color(0xFFC69840)),
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
                  decoration:   InputDecoration(
                    border: InputBorder.none,
                  ),
                  style:   TextStyle(fontSize: 14, color: Color(0xFFC69840)), // Reduced font size
                ),
              ),
              IconButton(
                icon:   Icon(Icons.add, color: Color(0xFFC69840)),
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
