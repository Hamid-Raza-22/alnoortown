import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../ViewModels/BlockDetailsViewModel/block_details_view_model.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

Widget buildPlotNumberRow({
  required List<String> plotNumbers,
  required String fromLabel,
  required String toLabel,
  required ValueChanged<String?> onFromPlotChanged,
  required ValueChanged<String?> onToPlotChanged,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: buildPlotDropdown(
          label: fromLabel,
          plotNumbers: plotNumbers,
          onChanged: onFromPlotChanged,
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: buildPlotDropdown(
          label: toLabel,
          plotNumbers: plotNumbers,
          onChanged: onToPlotChanged,
        ),
      ),
    ],
  );
}

Widget buildPlotDropdown({
  required String label,
  required List<String> plotNumbers,
  required ValueChanged<String?> onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color(0xFFC69840),
        ),
      ),
      const SizedBox(height: 8),
      DropdownSearch<String>(
        items: plotNumbers,
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
                style: const TextStyle(fontSize: 12),
              ),
            );
          },
        ),
        onChanged: onChanged,
      ),
    ],
  );
}

