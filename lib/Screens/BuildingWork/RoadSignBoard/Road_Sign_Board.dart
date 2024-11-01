import 'package:al_noor_town/Globals/globals.dart';
import 'package:al_noor_town/ViewModels/BlockDetailsViewModel/block_details_view_model.dart';
import 'package:al_noor_town/ViewModels/RoadDetailsViewModel/road_details_view_model.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' show ExtensionSnackbar, Get, GetNavigation, Inst, Obx, SnackPosition;
import '../../../Models/BuildingWorkModels/RoadsSignBoardsModel/roads_sign_boards_model.dart';
import '../../../ViewModels/BuildingWorkViewModel/RoadsSignBoardsViewModel/roads_sign_boards_view_model.dart';
import '../../../Widgets/container_data.dart';
import '../../../Widgets/custom_container_widgets.dart';
import '../../../Widgets/custom_plots_no_drowpdown_widgets.dart';
import '../../../Widgets/snackbar.dart';
import 'RoadSignBoardSummary.dart';

class RoadsSignBoards extends StatefulWidget {
    RoadsSignBoards({Key? key}) : super(key: key);
  @override
  _RoadsSignBoardsState createState() => _RoadsSignBoardsState();
}
class _RoadsSignBoardsState extends State<RoadsSignBoards> {
  RoadsSignBoardsViewModel roadsSignBoardsViewModel = Get.put(RoadsSignBoardsViewModel());
  BlockDetailsViewModel blockDetailsViewModel = Get.put(BlockDetailsViewModel());
  RoadDetailsViewModel roadDetailsViewModel = Get.put(RoadDetailsViewModel());
 String? fromPlotController;
  String? toPlotController;

  String? selectedroad_side;
  String? selectedStatus;


  void initState() {
    super.initState();
    containerData = createInitialContainerData();
  }

  Map<String, dynamic> createInitialContainerData() {
    return {
      "selectedBlock": null,
      "selectedStreet":null
    };
  }
  void _clearFields() {
    setState(() {
      containerData = createInitialContainerData();
      selectedStatus=null; // Clear the controller's text
      fromPlotController=null;
      selectedroad_side=null;
      selectedStatus = null;
      toPlotController=null;


    });
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Block Dropdown
                buildBlockSRoadsColumn(containerData, roadDetailsViewModel,blockDetailsViewModel),

                const SizedBox(height: 16), // Add spacing between dropdowns

              ],
            ),
            SizedBox(height: 10),

              SizedBox(height: 16),
            // Wherever you're using the widget (e.g., PlotSelectionPage)
            // Call the buildPlotNumberRow widget here
            buildPlotNumberRow(
              plotNumbers: blockDetailsViewModel.filteredPlots,
              fromLabel: 'From Plot Number',
              toLabel: 'To Plot Number',
              onFromPlotChanged: (value) {
                setState(() {
                  fromPlotController = value;
                }); // Update the controller variable
                blockDetailsViewModel.selectedFromPlot.value = value ?? ''; // Update ViewModel
              },
              onToPlotChanged: (value) {
                setState(() {
                  toPlotController = value;
                }); // Update the controller variable
                blockDetailsViewModel.selectedToPlot.value = value ?? ''; // Update ViewModel
              },
            ),

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
                  if (containerData["selectedBlock"] != null &&
                      containerData["selectedStreet"] != null &&
                      blockDetailsViewModel.selectedFromPlot.value.isNotEmpty &&
                      blockDetailsViewModel.selectedToPlot.value.isNotEmpty &&
                      selectedroad_side != null &&
                      selectedStatus != null) {
                    await roadsSignBoardsViewModel.addRoadsSignBoard(RoadsSignBoardsModel(
                        block_no: containerData["selectedBlock"],
                        road_no: containerData["selectedStreet"],
                       from_plot_no:blockDetailsViewModel.selectedFromPlot.value,
                       to_plot_no:  blockDetailsViewModel.selectedToPlot.value,
                        road_side: selectedroad_side,
                        comp_status: selectedStatus,
                        date: _getFormattedDate(),
                        time: _getFormattedTime(),
                      user_id: userId
                    ));

                    await roadsSignBoardsViewModel.fetchAllRoadsSignBoard();
                    await roadsSignBoardsViewModel.postDataFromDatabaseToAPI();

                    // Clear fields after submission
                    setState(() {
                      containerData = createInitialContainerData();
                    });
                    _clearFields();

                    showSnackBarSuccessfully(context);}
                  else{
                    showSnackBarPleaseFill(context);
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
          popupProps: PopupProps.menu(
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
