import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import '../ViewModels/RoadDetailsViewModel/road_details_view_model.dart';



Widget buildDropdownField(
    String title,
    Map<String, dynamic> containerData,
    String key,
    List<String> items,
    {Function(String)? onChanged}
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
      ),
      const SizedBox(height: 8),
      DropdownSearch<String>(
        items: items,
        selectedItem: containerData[key],
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF4A4A4A)),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        popupProps: PopupProps.bottomSheet(
          showSearchBox: true,
          itemBuilder: (context, item, isSelected) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          },
        ),
        onChanged: (value) {
          containerData[key] = value;
          if (onChanged != null && value != null) {
            onChanged(value);
          }
        },
      ),
    ],
  );
}

Widget buildBLockDropdownField(
    String title,
    Map<String, dynamic> containerData,
    String key,
    List<String> items,
    {Function(String)? onChanged}
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
      ),
      const SizedBox(height: 8),
      DropdownSearch<String>(
        items: items,
        selectedItem: containerData[key],
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFF4A4A4A)),
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        popupProps: PopupProps.bottomSheet(
          showSearchBox: true,
          itemBuilder: (context, item, isSelected) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(item, style: const TextStyle(fontSize: 14)),
            );
          },
        ),
        onChanged: (value) {
          containerData[key] = value;
          if (onChanged != null && value != null) {
            onChanged(value);
          }
        },
      ),
    ],
  );
}

Widget buildBlockStreetRow(Map<String, dynamic> containerData, RoadDetailsViewModel roadDetailsViewModel) {
  return Obx(() {
    final List<String> blocks = roadDetailsViewModel.allRoadDetails
        .map((detail) => detail.block.toString())
        .toSet()
        .toList();

    return Row(
      children: [
        Expanded(
          child: buildDropdownField(
            "block_no".tr(),
            containerData,
            "selectedBlock",
            blocks,
            onChanged: (selectedBlock) {
              roadDetailsViewModel.updateFilteredStreets(selectedBlock);
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: buildDropdownField(
            "street_no".tr(),
            containerData,
            "selectedStreet",
            roadDetailsViewModel.filteredStreets,
          ),
        ),
      ],
    );
  });
}

Widget buildBlockRow(Map<String, dynamic> containerData, RoadDetailsViewModel roadDetailsViewModel) {
  return Obx(() {
    final List<String> blocks = roadDetailsViewModel.allRoadDetails
        .map((detail) => detail.block.toString())
        .toSet()
        .toList();

    return Row(
      children: [
        Expanded(
          child: buildDropdownField(
            "from_block".tr(),
            containerData,
            "selectedBlock",
            blocks,

          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: buildDropdownField(
            "to_block".tr(),
            containerData,
            "selectedStreet",
              blocks,
          ),
        ),
      ],
    );
  });
}

