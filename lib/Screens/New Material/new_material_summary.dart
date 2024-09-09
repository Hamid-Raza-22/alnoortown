import 'package:al_noor_town/ViewModels/NewMaterialViewModel/new_material_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;

class NewMaterialSummary extends StatelessWidget {
  NewMaterialViewModel newMaterialViewModel = Get.put(NewMaterialViewModel());
  NewMaterialSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    newMaterialViewModel.fetchAllNewMaterial();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'new_material_summary'.tr(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(isPortrait ? 16.0 : 24.0),
    child: Obx(() {
      // Use Obx to rebuild when the data changes
      if (newMaterialViewModel.allNew.isEmpty) {
        return Center(
            child: CircularProgressIndicator()); // Show loading indicator
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            // Header row
            Row(
              children: [
                buildHeaderCell('date'.tr()),
                buildHeaderCell('time'.tr()),
                buildHeaderCell('sand'.tr()),
                buildHeaderCell('soil'.tr()),
                buildHeaderCell('base'.tr()),
                buildHeaderCell('sub_base'.tr()),
                buildHeaderCell('water_bound'.tr()),
                buildHeaderCell('other_material'.tr()),
                buildHeaderCell('other_quantity'.tr()),
              ],
            ),
            const SizedBox(height: 10),
            // Data rows
            ...newMaterialViewModel.allNew.map((entry) {
              return Row(
                children: [
                  buildDataCell(entry.date?.toString() ?? 'N/A'),
                  buildDataCell(entry.time?.toString() ?? 'N/A'),
                  buildDataCell(entry.sand?.toString() ?? 'N/A'),
                  buildDataCell(entry.soil?.toString() ?? 'N/A'),
                  buildDataCell(entry.base?.toString() ?? 'N/A'),
                  buildDataCell(entry.subBase?.toString() ?? 'N/A'),
                  buildDataCell(entry.waterBound?.toString() ?? 'N/A'),
                  buildDataCell(entry.otherMaterial?.toString() ?? 'N/A'),
                  buildDataCell(entry.otherMaterialValue?.toString() ?? 'N/A'),
                ],
              );
            }).toList(),
          ],
        ),
      );
    }),
        ),
    );

  }

  Widget buildHeaderCell(String text) {
    return Container(
      width: 120, // Adjust as needed
      padding: const EdgeInsets.all(8.0),
      color: const Color(0xFFC69840),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget buildDataCell(String text) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(fontSize: 12.0),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
