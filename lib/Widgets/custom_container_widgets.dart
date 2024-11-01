import 'package:al_noor_town/ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;

import '../ViewModels/RoadDetailsViewModel/road_details_view_model.dart';

Widget buildBlockSRoadsColumn(
    Map<String, dynamic> containerData,
    RoadDetailsViewModel roadDetailsViewModel,
    BlockDetailsViewModel blockDetailsViewModel
    ) {
  return Obx(() {
    // Get the list of unique blocks from the road details
    final List<String> blocks = roadDetailsViewModel.allRoadDetails
        .map((detail) => detail.block.toString())
        .toSet()
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDropdownRow(
        "block_no".tr(),
    containerData,
    "selectedBlock",
    blocks,
    onChanged: (selectedBlock) {
      roadDetailsViewModel.updateFilteredStreets(selectedBlock);
    },
        ),

        const SizedBox(height: 16),
        buildDropdownRow(
          "street_no".tr(),
          containerData,
          "selectedStreet",
          roadDetailsViewModel.filteredStreets,
        ),
      ],
    );
  });
}

Widget buildDropdownRow(
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
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFFC69840),
        ),
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
        popupProps: PopupProps.menu(
          showSearchBox: true,
          itemBuilder: (context, item, isSelected) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                item,
                style: const TextStyle(fontSize: 11),
              ),
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
