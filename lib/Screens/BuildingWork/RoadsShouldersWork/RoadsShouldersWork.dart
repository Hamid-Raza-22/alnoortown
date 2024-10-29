import 'package:al_noor_town/Globals/globals.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:al_noor_town/Models/BuildingWorkModels/RoadsShoulderWorkModel/roads_shoulder_work_model.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/RoadsShouldersWorkViewModel/roads_shoulder_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import 'package:intl/intl.dart';
import '../../../ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import '../../../ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import '../../../Widgets/container_data.dart';
import '../../../Widgets/custom_container_widgets.dart';
import 'RoadsShouldersWorkSummary.dart';

class RoadsShouldersWork extends StatefulWidget {
    RoadsShouldersWork({super.key});

  @override
  _RoadsShouldersWorkState createState() => _RoadsShouldersWorkState();
}

class _RoadsShouldersWorkState extends State<RoadsShouldersWork> {
  RoadsShoulderWorkViewModel roadsShoulderWorkViewModel = Get.put(RoadsShoulderWorkViewModel());
  DateTime? selectedstart_date;
  DateTime? selectedEndDate;
 TextEditingController total_lengthController = TextEditingController();

  String? selectedroad_side;
  String? selectedStatus;
 
  BlockDetailsViewModel blockDetailsViewModel = Get.put(BlockDetailsViewModel());
  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());

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
          icon:   Icon(Icons.arrow_back, color: Color(0xFFC69840)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon:   Icon(Icons.history_edu_outlined, color: Color(0xFFC69840)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      RoadsShouldersSummary(),
                ),
              );
            },
          ),
        ],
        title:   Text(
          'roads_shoulders_work'.tr(),
          style: TextStyle(
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
              padding:   EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildContainer(),
                    SizedBox(height: 16),
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
      margin:   EdgeInsets.only(bottom: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      child: Padding(
        padding:   EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Block Dropdown
                buildBlockSRoadsColumn(containerData, roadDetailsViewModel, blockDetailsViewModel),

                const SizedBox(height: 16), // Add spacing between dropdowns

              ],
            ),
              SizedBox(height: 16),
            buildDropdownRow('road_side'.tr(), selectedroad_side, ['left'.tr(), 'right'.tr()], (value) { // Dropdown for Road Side
              setState(() {
                selectedroad_side = value;
              });
            }),
              SizedBox(height: 16),
            buildTextFieldRow('total_length'.tr(), total_lengthController),
              SizedBox(height: 16),
            buildDatePickerRow(
              'start_date'.tr(),
              selectedstart_date,
                  (date) => setState(() => selectedstart_date = date),
            ),
              SizedBox(height: 16),
            buildDatePickerRow(
              'expected_completion_date'.tr(),
              selectedEndDate,
                  (date) => setState(() => selectedEndDate = date),
            ),
              SizedBox(height: 16),
              Text(
              'roads_edging_work_completion_status'.tr(),
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC69840)),
            ),
              SizedBox(height: 8),
            buildStatusRadioButtons((value) {
              setState(() {
                selectedStatus = value;
              });
            }),
              SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (selectedstart_date != null &&
                      selectedEndDate != null &&
                      total_lengthController.text.isNotEmpty &&
                      containerData["selectedBlock"] != null &&
                      containerData["selectedStreet"] != null &&
                      selectedroad_side != null && // Check if Road Side is selected
                      selectedStatus != null) {
                    await roadsShoulderWorkViewModel.addRoadShoulder(RoadsShoulderWorkModel(
                        start_date: selectedstart_date,
                        expected_comp_date: selectedEndDate,
                        block_no: containerData["selectedBlock"],
                        road_no: containerData["selectedStreet"],
                        road_side: selectedroad_side,
                        total_length: total_lengthController.text,
                        roads_shoulder_comp_status: selectedStatus,
                        date: _getFormattedDate(),
                        time: _getFormattedTime(),
                      user_id: userId
                    ));

                    await roadsShoulderWorkViewModel.fetchAllRoadShoulder();
                    await roadsShoulderWorkViewModel.postDataFromDatabaseToAPI();

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                        content: Text('entry_added_successfully'.tr()),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                        content: Text('please_fill_in_all_fields'.tr()),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:   Color(0xFFF3F4F6),
                  padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle:   TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child:   Text('submit'.tr().tr(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownRow(
      String title, String? selectedItem, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFFC69840),
          ),
        ),
        SizedBox(height: 8),
        DropdownSearch<String>(
          items: items,
          selectedItem: selectedItem,
          dropdownDecoratorProps: DropDownDecoratorProps(
            dropdownSearchDecoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF4A4A4A)),
                borderRadius: BorderRadius.circular(8), // Adjust border radius
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Adjust padding
            ),
          ),
          popupProps: PopupProps.dialog(
            showSearchBox: true, // Enables the search feature
            itemBuilder: (context, item, isSelected) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  item,
                  style: TextStyle(fontSize: 11), // Adjust font size for dropdown items
                ),
              );
            },
          ),
          onChanged: onChanged, // Passes the selected value back to the caller
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
          style:   TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC69840)),
        ),
          SizedBox(height: 8),
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
            padding:   EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color:   Color(0xFFC69840)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              selectedDate != null
                  ? DateFormat('d MMM yyyy').format(selectedDate)
                  : 'select_date'.tr(),
              style:   TextStyle(
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
          style:   TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC69840)),
        ),
          SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration:   InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
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
