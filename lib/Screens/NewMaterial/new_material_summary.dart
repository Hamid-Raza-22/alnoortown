import 'package:al_noor_town/ViewModels/NewMaterialViewModel/new_material_view_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show Get,Inst ,Obx;
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;

class NewMaterialSummary extends StatelessWidget {
  NewMaterialViewModel newMaterialViewModel = Get.put(NewMaterialViewModel());
  DateTime? fromDate;
  DateTime? toDate;

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
        child: Column(
          children: [
            // Date Filter Widget
            DateFilterWidget(
              onFilter: (DateTime? from, DateTime? to) {
                fromDate = from;
                toDate = to;
                newMaterialViewModel.fetchAllNewMaterial(); // Re-fetch the data when date changes
              },
            ),
            Expanded(
              child: Obx(() {
                if (newMaterialViewModel.allNew.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Filter data by date range
                var filteredData = newMaterialViewModel.allNew.where((entry) {
                  if (fromDate != null && entry.date != null && entry.date!.isBefore(fromDate!)) {
                    return false;
                  }
                  if (toDate != null && entry.date != null && entry.date!.isAfter(toDate!)) {
                    return false;
                  }
                  return true;
                }).toList();

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
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
                      ...filteredData.map((entry) {
                        return Row(
                          children: [
                            buildDataCell(entry.date?.toString() ?? 'N/A'),
                            buildDataCell(entry.time?.toString() ?? 'N/A'),
                            buildDataCell(entry.sand?.toString() ?? 'N/A'),
                            buildDataCell(entry.soil?.toString() ?? 'N/A'),
                            buildDataCell(entry.base?.toString() ?? 'N/A'),
                            buildDataCell(entry.sub_base?.toString() ?? 'N/A'),
                            buildDataCell(entry.water_bound?.toString() ?? 'N/A'),
                            buildDataCell(entry.other_material?.toString() ?? 'N/A'),
                            buildDataCell(entry.other_material_value?.toString() ?? 'N/A'),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );

  }

  Widget buildHeaderCell(String text) {
    return Container(
      width: 120,
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

class DateFilterWidget extends StatefulWidget {
  final Function(DateTime? fromDate, DateTime? toDate) onFilter;

  DateFilterWidget({required this.onFilter});

  @override
  _DateFilterWidgetState createState() => _DateFilterWidgetState();
}

class _DateFilterWidgetState extends State<DateFilterWidget> {
  DateTime? selectedFromDate;
  DateTime? selectedToDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStyledDateField(context, selectedFromDate, (date) {
                  setState(() {
                    selectedFromDate = date;
                  });
                }, "From"),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStyledDateField(context, selectedToDate, (date) {
                  setState(() {
                    selectedToDate = date;
                  });
                }, "To"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                widget.onFilter(selectedFromDate, selectedToDate);
              },
              child: const Text(
                "Search",
                style: TextStyle(color: Color(0xFFC69840)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStyledDateField(
      BuildContext context, DateTime? selectedDate, Function(DateTime?) onDateSelected, String placeholder) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(
                  primary: Color(0xFFC69840), // Gold color for the header
                  onPrimary: Colors.white, // Text color for the header
                  onSurface: Colors.black, // Text color for the rest of the calendar
                ),
                dialogBackgroundColor: Colors.white,
              ),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onDateSelected(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: placeholder,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC69840), width: 1.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        ),
        child: Text(
          selectedDate != null
              ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
              : placeholder,
          style: TextStyle(color: selectedDate != null ? Colors.black : Colors.grey[600]),
        ),
      ),
    );
  }
}

