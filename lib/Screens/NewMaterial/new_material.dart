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
import '../../Widgets/snackbar.dart';
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

  String? selectedBlock;
  TextEditingController totalDumpersController = TextEditingController();
  TextEditingController sandController = TextEditingController();
  TextEditingController soilController = TextEditingController();
  TextEditingController baseController = TextEditingController();
  TextEditingController subBaseController = TextEditingController();
  TextEditingController otherMaterialController = TextEditingController();
  TextEditingController waterBoundController = TextEditingController();
  Map<String, dynamic> containerData = {};
  @override
  void initState() {
    super.initState();
    containerData = createInitialContainerData();
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
  void _clearFields() {
    setState(() {
      containerData = createInitialContainerData();
      totalDumpersController.clear();// Clear the controller's text
      sandController.clear();
      soilController.clear();
      baseController.clear();
      subBaseController.clear();
      otherMaterialController.clear();
      waterBoundController.clear();
    });
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'new_material'.tr(),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildBlockColumn(containerData, roadDetailsViewModel, blockDetailsViewModel),
            buildLabelsAndFields(
              containerData,
              [sandController, soilController],
              ['sand'.tr(), 'soil'.tr()],
            ),
            const SizedBox(height: 16),
            buildLabelsAndFields( containerData,[baseController, subBaseController], ['base'.tr(), 'sub_base'.tr()]),
            const SizedBox(height: 16),
            buildOtherMaterialRow( containerData),
            const SizedBox(height: 16),
            buildLabelsAndFields( containerData,[waterBoundController], ['water_bound'.tr()]),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  selectedBlock = containerData["selectedBlock"];
                  final sand = containerData["sand"];
                  final soil = containerData["soil"];
                  final base = containerData["base"];
                  final sub_base = containerData["sub_base"];
                  final water_bound = containerData["water_bound"];
                  final other_material = containerData["other_material"];
                  final other_material_value = containerData["other_material_value"];
                  if (selectedBlock != null) {
                    await newMaterialViewModel.addNewMaterial(
                      NewMaterialModel(
                          block: containerData["selectedBlock"],
                          sand: sand,
                          soil: soil,
                          sub_base: sub_base,
                          base: base,
                          water_bound: water_bound,
                          other_material: other_material,
                          other_material_value: other_material_value,
                          date: _getFormattedDate(),
                          time: _getFormattedTime(),
                          user_id: userId
                      ),
                    );

                    await newMaterialViewModel.fetchAllNewMaterial();
                    await newMaterialViewModel.postDataFromDatabaseToAPI();


                    // Clear fields after submission
                    setState(() {
                      containerData = createInitialContainerData();
                    });
                    _clearFields();

                    showSnackBarSuccessfully(context);
                  }
                  else {
                    showSnackBarPleaseFill(context);
                  }
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

  Widget buildLabelsAndFields(
      Map<String, dynamic> containerData, List<TextEditingController> controllers, List<String> labels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(labels.length, (index) {
        String label = labels[index];
        String fieldName = getFieldName(label);
        TextEditingController controller = controllers[index];
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: buildEditableTextField(label, containerData, controller, fieldName),
          ),
        );
      }),
    );
  }

  Widget buildEditableTextField(String label, Map<String, dynamic> containerData,
      TextEditingController controller, String fieldName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        TextField(
          controller: controller,
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
  Widget buildOtherMaterialRow( Map<String, dynamic> containerData) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                "Other Material".tr(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: otherMaterialController,
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
                controller: totalDumpersController,
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
