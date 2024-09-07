import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Models/NewMaterialModels/new_material_model.dart';
import 'package:al_noor_town/ViewModels/NewMaterialViewModel/new_material_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, GetNavigation, Inst;
import 'new_material_summary.dart';

class NewMaterial extends StatefulWidget {
  NewMaterial({super.key});

  @override
  _NewMaterialState createState() => _NewMaterialState();
}

class _NewMaterialState extends State<NewMaterial> {
  NewMaterialViewModel newMaterialViewModel = Get.put(NewMaterialViewModel());
  DBHelper dbHelper = DBHelper();
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
          actions: [
            IconButton(
              icon: const Icon(Icons.summarize, color: Color(0xFFC69840)),
              onPressed: () {
                Get.to(NewMaterialSummary());
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
            const SizedBox(height: 20),
            Center(
              child: Text(
                'new_material'.tr(),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildLabelsAndFields(index, containerData, ['Sand', 'Soil']),
            const SizedBox(height: 16),
            buildLabelsAndFields(index, containerData, ['Base', 'Sub Base']),
            const SizedBox(height: 16),
            buildOtherMaterialRow(index, containerData),
            const SizedBox(height: 16),
            buildLabelsAndFields(index, containerData, ['Water Bound']),
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
                  await newMaterialViewModel.addNewMaterial(
                    NewMaterialModel(
                      sand: sand,
                      soil: soil,
                      subBase: subBase,
                      base: base,
                      waterBound: waterBound,
                      otherMaterial: otherMaterial,
                      date: _getFormattedDate(),
                      time: _getFormattedTime(),
                    ),
                  );

                  await newMaterialViewModel.fetchAllNewMaterial();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Data Submitted: $containerData'),
                    ),
                  );

                  setState(() {
                    containerDataList[index] = createInitialContainerData();
                    containerDataList = [createInitialContainerData()];
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF3F4F6),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: const TextStyle(fontSize: 14),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text('submit'.tr(), style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLabelsAndFields(int index, Map<String, dynamic> containerData, List<String> labels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: labels.map((label) {
        String fieldName = getFieldName(label);
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: buildEditableTextField(label, containerData, fieldName),
          ),
        );
      }).toList(),
    );
  }

  Widget buildEditableTextField(String label, Map<String, dynamic> containerData, String fieldName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              containerData[fieldName] = int.tryParse(value) ?? 0;
            });
          },
          decoration: InputDecoration(
            hintText: 'Enter value',
            hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFC69840)),
            ),
          ),
          style: const TextStyle(color: Color(0xFFC69840)),
        ),
      ],
    );
  }

  Widget buildOtherMaterialRow(int index, Map<String, dynamic> containerData) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Other Material",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: (value) {
                  setState(() {
                    containerData["otherMaterial"] = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter other material',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC69840)),
                  ),
                ),
                style: const TextStyle(color: Color(0xFFC69840)),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Quantity",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    containerData["otherMaterialValue"] = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Qty',
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.4)),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFC69840)),
                  ),
                ),
                style: const TextStyle(color: Color(0xFFC69840)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String getFieldName(String label) {
    switch (label) {
      case 'Sand':
        return 'sand';
      case 'Soil':
        return 'soil';
      case 'Base':
        return 'base';
      case 'Sub Base':
        return 'subBase';
      case 'Water Bound':
        return 'waterBound';
      default:
        return '';
    }
  }
}
