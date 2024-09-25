import 'package:easy_localization/easy_localization.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsCompactionWork/compaction_water_bound_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsCompactionWorkViewModel/compaction_water_bound_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import 'package:intl/intl.dart';
import 'WaterBoundSummary.dart';

class CompactionAfterWaterBound extends StatefulWidget {
  CompactionAfterWaterBound({super.key});

  @override
  _CompactionAfterWaterBoundState createState() => _CompactionAfterWaterBoundState();
}

class _CompactionAfterWaterBoundState extends State<CompactionAfterWaterBound> {
  CompactionWaterBoundViewModel compactionWaterBoundViewModel = Get.put(CompactionWaterBoundViewModel());
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TextEditingController roadNoController = TextEditingController();
  TextEditingController totalLengthController = TextEditingController();
  String? selectedBlock;
  String? selectedStatus;
  List<Map<String, dynamic>> containerDataList = [];

  @override
  void initState() {
    super.initState();
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:   const Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon:   const Icon(Icons.history_edu_outlined, color: Color(0xFFC69840)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      WaterBoundSummary(),
                ),
              );
            },
          ),
        ],
        title:   Text(
          'compaction_after_water_bound'.tr(),
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/mosqueExcavationWork.png',
              fit: BoxFit.cover,
              height: 170.0,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding:   const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildContainer(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContainer() {
    return Card(
      margin:   const EdgeInsets.only(bottom: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding:   const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildDropdownRow('block_no'.tr(), selectedBlock, ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"], (value) {
              setState(() {
                selectedBlock = value;
              });
            }),
            const SizedBox(height: 16),
            buildTextFieldRow('road_no'.tr(), roadNoController),
            const SizedBox(height: 16),
            buildTextFieldRow('total_length'.tr(), totalLengthController),
            const SizedBox(height: 16),
            buildDatePickerRow(
              'start_date'.tr(),
              selectedStartDate,
                  (date) => setState(() => selectedStartDate = date),
            ),
            const SizedBox(height: 16),
            buildDatePickerRow(
              'expected_completion_date'.tr(),
              selectedEndDate,
                  (date) => setState(() => selectedEndDate = date),
            ),
            const SizedBox(height: 16),
            Text(
              'sand_compaction_completion_status'.tr(),
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC69840)),
            ),
            const SizedBox(height: 8),
            buildStatusRadioButtons((value) {
              setState(() {
                selectedStatus = value;
              });
            }),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    if (selectedStartDate != null &&
                        selectedEndDate != null &&
                        roadNoController.text.isNotEmpty &&
                        totalLengthController.text.isNotEmpty &&
                        selectedBlock != null &&
                        selectedStatus != null) {

                      // Create and add the model
                      await compactionWaterBoundViewModel.addWaterBound(CompactionWaterBoundModel(
                          startDate: selectedStartDate,
                          expectedCompDate: selectedEndDate,
                          roadNo: roadNoController.text,
                          totalLength: totalLengthController.text,
                          block_no: selectedBlock,
                          waterBoundCompStatus: selectedStatus,
                          date: _getFormattedDate(),
                          time: _getFormattedTime()
                      ));

                      await compactionWaterBoundViewModel.fetchAllWaterBound();

                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('entry_added_successfully'.tr()),
                        ),
                      );

                      // Clear the fields after successful submission
                      roadNoController.clear();
                      totalLengthController.clear();
                      selectedBlock = null;
                      selectedStatus = null;
                      selectedStartDate = null;
                      selectedEndDate = null;

                      // Optionally, you may want to set the dropdown and radio button states
                      setState(() {}); // This will trigger a rebuild to update the UI
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('please_fill_in_all_fields'.tr()),
                        ),
                      );
                    }
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor:   const Color(0xFFF3F4F6),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle:   const TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child:   Text('submit'.tr().tr(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownRow(String label, String? selectedValue, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:   const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC69840)),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          decoration:   const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget buildDatePickerRow(String label, DateTime? selectedDate, ValueChanged<DateTime?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:   const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC69840)),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            onChanged(pickedDate);
          },
          child: Container(
            width: double.infinity,
            padding:   const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFC69840)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              selectedDate != null
                  ? DateFormat('d MMM yyyy').format(selectedDate)
                  : 'select_date'.tr(),
              style:   const TextStyle(
                fontSize: 14,
                color: Color(0xFFC69840),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextFieldRow(String label, TextEditingController controller) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style:   const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC69840)),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration:   const InputDecoration(
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        ]
    );
  }

  Widget buildStatusRadioButtons(ValueChanged<String?> onChanged) {
    return Column(
      children: [
        RadioListTile<String>(
          title:   Text('in_process'.tr()),
          value: "In Process",
          groupValue: selectedStatus,
          onChanged: onChanged,
        ),
        RadioListTile<String>(
          title:  Text('done'.tr()),
          value: 'done'.tr(),
          groupValue: selectedStatus,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
