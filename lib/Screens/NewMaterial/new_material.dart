import 'package:al_noor_town/Database/db_helper.dart';
import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/Models/NewMaterialModels/new_material_model.dart';
import 'package:al_noor_town/ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import 'package:al_noor_town/ViewModels/NewMaterialViewModel/new_material_view_model.dart';
import 'package:al_noor_town/ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import 'package:al_noor_town/Widgets/buildBlockRow.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' show Get, GetNavigation, Inst;
import '../../Widgets/container_data.dart';
import 'new_material_summary.dart';

class NewMaterial extends StatefulWidget {
  NewMaterial({super.key});

  @override
  _NewMaterialState createState() => _NewMaterialState();
}

class _NewMaterialState extends State<NewMaterial> {
  NewMaterialViewModel newMaterialViewModel = Get.put(NewMaterialViewModel());
  BlockDetailsViewModel blockDetailsViewModel = Get.put(BlockDetailsViewModel());
  RoadDetailsViewModel roadDetailsViewModel =Get.put(RoadDetailsViewModel());
  DBHelper dbHelper = DBHelper();
  List<Map<String, dynamic>> containerDataList = [];
  String? selectedBlock;

  @override
  void initState() {
    super.initState();
    containerDataList.add(createInitialContainerData());
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "block":0,
      "sand": 0,
      "soil": 0,
      "base": 0,
      "sub_base": 0,
      "water_bound": 0,
      "other_material": "",
      "other_material_value": 0,
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
    var containerData2 = containerDataList[index];

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
            buildBlockColumn(containerData, roadDetailsViewModel, blockDetailsViewModel),
            buildLabelsAndFields(index, containerData2, ['sand'.tr(), 'soil'.tr()]),
            const SizedBox(height: 16),
            buildLabelsAndFields(index, containerData2, ['base'.tr(), 'sub_base'.tr()]),
            const SizedBox(height: 16),
            buildOtherMaterialRow(index, containerData2),
            const SizedBox(height: 16),
            buildLabelsAndFields(index, containerData2, ['water_bound'.tr()]),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final sand = containerData2["sand"];
                  final soil = containerData2["soil"];
                  final base = containerData2["base"];
                  final sub_base = containerData2["sub_base"];
                  final water_bound = containerData2["water_bound"];
                  final other_material = containerData2["other_material"];
                  final other_material_value = containerData2["other_material_value"];
                  await newMaterialViewModel.addNewMaterial(
                    NewMaterialModel(
                      block: containerData["selectedBlock"],
                      sand: sand,
                      soil: soil,
                      sub_base: sub_base,
                      base: base,
                      water_bound: water_bound,
                      other_material: other_material,
                      other_material_value:other_material_value ,
                      date: _getFormattedDate(),
                      time: _getFormattedTime(),
                      user_id: userId
                    ),
                  );

                  await newMaterialViewModel.fetchAllNewMaterial();
                  await newMaterialViewModel.postDataFromDatabaseToAPI();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Data Submitted: $containerData2'),
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
            hintText: 'total_dumpers'.tr(),
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
               Text(
                "other_material".tr(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
              ),
              const SizedBox(height: 8),
              TextField(
                onChanged: (value) {
                  setState(() {
                    containerData["other_material"] = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: "total_dumpers".tr(),
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
               Text(
                "total_dumpers".tr(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    containerData["other_material_value"] = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  hintText: "total_dumpers".tr(),
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
        return 'sub_base';
      case 'Water Bound':
        return 'water_bound';
      default:
        return '';
    }
  }
}
