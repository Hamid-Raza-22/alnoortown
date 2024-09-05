import 'package:al_noor_town/Models/BuildingWorkModels/StreetRoadsWaterChannelsModel/street_road_water_channel_model.dart';
import 'package:al_noor_town/Screens/Building%20Work/Street%20Roads%20Water%20Channels/waterchannelsummary.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:al_noor_town/ViewModels/BuildingWorkViewModel/StreetRoadwaterChannelViewModel/street_road_water_channel_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import 'package:intl/intl.dart';

class StreetRoadsWaterChannels extends StatefulWidget {
    StreetRoadsWaterChannels({super.key});

  @override
  _StreetRoadsWaterChannelsState createState() => _StreetRoadsWaterChannelsState();
}

class _StreetRoadsWaterChannelsState extends State<StreetRoadsWaterChannels> {
  StreetRoadWaterChannelViewModel streetRoadWaterChannelViewModel = Get.put(StreetRoadWaterChannelViewModel());
  TextEditingController roadNoController = TextEditingController();
  TextEditingController noOfWaterChannelsController = TextEditingController();
  String? selectedBlock;
  String? selectedRoadSide;
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
  // Future<void> _loadData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? savedData = prefs.getString('WaterChannelsDataList');
  //   if (savedData != null) {
  //     setState(() {
  //       containerDataList = List<Map<String, dynamic>>.from(json.decode(savedData));
  //     });
  //   }
  // }
  //
  // Future<void> _saveData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('WaterChannelsDataList', json.encode(containerDataList));
  // }
  //
  // Map<String, dynamic> createNewEntry(String? block, String? roadNo, String? roadSide, String? noOfWaterChannels, String? status) {
  //   return {
  //     "block": block,
  //     "roadNo": roadNo,
  //     "roadSide": roadSide,
  //     "noOfWaterChannels": noOfWaterChannels,
  //     "status": status,
  //     "timestamp": DateTime.now().toIso8601String(),
  //   };
  // }

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
                      WaterChannelsSummary(containerDataList: containerDataList),
                ),
              );
            },
          ),
        ],
        title: const Text(
          'Street Roads Water Channels',
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
            buildDropdownRow('block_no'.tr(), selectedBlock, ["Block A", "Block B", "Block C", "Block D", "Block E", "Block F", "Block G"], (value) {
              setState(() {
                selectedBlock = value;
              });
            }),
              SizedBox(height: 16),
            buildTextFieldRow('road_no'.tr(), roadNoController),
              SizedBox(height: 16),
            buildDropdownRow('road_side'.tr(), selectedRoadSide, ["Left", "Right"], (value) {
              setState(() {
                selectedRoadSide = value;
              });
            }),
              SizedBox(height: 16),
            buildTextFieldRow('no_of_water_channels'.tr(), noOfWaterChannelsController),
              SizedBox(height: 16),
              Text(
              'water_channels_completion_status'.tr(),
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
                  if (roadNoController.text.isNotEmpty &&
                      noOfWaterChannelsController.text.isNotEmpty &&
                      selectedBlock != null &&
                      selectedRoadSide != null && // Check if Road Side is selected
                      selectedStatus != null) {
                    await streetRoadWaterChannelViewModel.addStreetRoad(StreetRoadWaterChannelModel(
                        blockNo: selectedBlock,
                        roadNo: roadNoController.text,
                        roadSide: selectedRoadSide,
                        noOfWaterChannels: noOfWaterChannelsController.text,
                        waterChCompStatus: selectedStatus,
                        date: _getFormattedDate(),
                        time: _getFormattedTime()

                    ));

                    await streetRoadWaterChannelViewModel.fetchAllStreetRoad();

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

  Widget buildDropdownRow(String label, String? selectedValue, List<String> items, ValueChanged<String?> onChanged) {
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
          value: 'in_process'.tr(),
          groupValue: selectedStatus,
          onChanged: onChanged,
        ),
        RadioListTile<String>(
          title:   Text('done'.tr()),
          value: "Done",
          groupValue: selectedStatus,
          onChanged: onChanged,
        ),
      ],
    );
  }
}