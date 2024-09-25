import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import 'package:intl/intl.dart';
import '../../../Models/BuildingWorkModels/RoadsSignBoardsModel/roads_sign_boards_model.dart';
import '../../../ViewModels/BuildingWorkViewModel/RoadsSignBoardsViewModel/roads_sign_boards_view_model.dart';
import 'RoadSignBoardSummary.dart';

class RoadsSignBoards extends StatefulWidget {
    RoadsSignBoards({Key? key}) : super(key: key);
  @override
  _RoadsSignBoardsState createState() => _RoadsSignBoardsState();
}
class _RoadsSignBoardsState extends State<RoadsSignBoards> {
  RoadsSignBoardsViewModel roadsSignBoardsViewModel = Get.put(RoadsSignBoardsViewModel());
  TextEditingController road_noController = TextEditingController();
  TextEditingController fromPlotController = TextEditingController();
  TextEditingController toPlotController = TextEditingController();
  String? selectedBlock;
  String? selectedroad_side;
  String? selectedStatus;
  List<Map<String, dynamic>> containerDataList = [];

  @override
  void initState() {
    super.initState();
    // _loadData();
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
                  builder: (context) => RoadSignBoardSummary(),
                ),
              );
            },
          ),
        ],
        title:   Text(
         'roads_sign_boards'.tr(),
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.asset(
              'assets/images/qw-01.png',
              fit: BoxFit.cover,
              height: 200.0,
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
            buildDropdownRow('block_no'.tr(), selectedBlock, ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"], (value) {
              setState(() {
                selectedBlock = value;
              });
            }),
              SizedBox(height: 16),
            buildTextFieldRow('road_no'.tr(), road_noController),
              SizedBox(height: 16),
            buildPlotNumberRow(),
              SizedBox(height: 16),
            buildDropdownRow('road_side'.tr(), selectedroad_side, ['left'.tr(), 'right'.tr()], (value) {
              setState(() {
                selectedroad_side = value;
              });
            }),
              SizedBox(height: 16),
              Text(
              'work_status'.tr(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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
                  if (selectedBlock != null &&
                      road_noController.text.isNotEmpty &&
                      fromPlotController.text.isNotEmpty &&
                      toPlotController.text.isNotEmpty &&
                      selectedroad_side != null &&
                      selectedStatus != null) {
                    await roadsSignBoardsViewModel.addRoadsSignBoard(RoadsSignBoardsModel(
                       block_no: selectedBlock,
                       road_no: road_noController.text,
                       from_plot_no:fromPlotController.text,
                       to_plot_no: toPlotController.text,
                        road_side: selectedroad_side,
                        comp_status: selectedStatus,
                        date: _getFormattedDate(),
                        time: _getFormattedTime()
                    ));

                    await roadsSignBoardsViewModel.fetchAllRoadsSignBoard();

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
                  padding:   EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle:   TextStyle(fontSize: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child:   Text('submit'.tr().tr(),
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC69840))),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPlotNumberRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: buildTextField('from_plot_no'.tr(), fromPlotController),
        ),
          SizedBox(width: 16),
        Expanded(
          child: buildTextField('to_plot_no'.tr(), toPlotController),
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
          style:   TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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

  Widget buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:   TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
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

  Widget buildDropdownRow(String label, String? selectedValue, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:   TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFC69840)),
        ),
          SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedValue,
          decoration:   InputDecoration(
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
