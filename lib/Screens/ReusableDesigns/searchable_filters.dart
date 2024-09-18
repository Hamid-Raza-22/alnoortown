import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MachineFilters extends StatefulWidget {
  final Function(String blockNo, String streetNo, DateTime? fromDate, DateTime? toDate) onApplyFilters;

  const MachineFilters({required this.onApplyFilters, Key? key}) : super(key: key);

  @override
  _MachineFiltersState createState() => _MachineFiltersState();
}

class _MachineFiltersState extends State<MachineFilters> {
  final TextEditingController blockNoController = TextEditingController();
  final TextEditingController streetNoController = TextEditingController();
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Block No. field
        TextField(
          controller: blockNoController,
          decoration: InputDecoration(
            labelText: 'block_no'.tr(),
            labelStyle: TextStyle(color: const Color(0xFFC69840)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: const Color(0xFFC69840)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: const Color(0xFFC69840)),
            ),
          ),
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 14.0),
        ),
        const SizedBox(height: 10),
        // Street No. field
        TextField(
          controller: streetNoController,
          decoration: InputDecoration(
            labelText: 'street_no'.tr(),
            labelStyle: TextStyle(color: const Color(0xFFC69840)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: const Color(0xFFC69840)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(color: const Color(0xFFC69840)),
            ),
          ),
        keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 14.0),
        ),
        const SizedBox(height: 10),
        // From Date field
        Row(
          children: [
            Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'from_date'.tr(),
                  labelStyle: TextStyle(color: const Color(0xFFC69840)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: const Color(0xFFC69840)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: const Color(0xFFC69840)),
                  ),
                  suffixIcon: Icon(Icons.calendar_today, color: const Color(0xFFC69840)),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    helpText: 'Select from date',
                  );
                  if (selectedDate != null) {
                    setState(() {
                      fromDate = selectedDate;
                    });
                  }
                },
                controller: TextEditingController(
                  text: fromDate != null ? DateFormat('yyyy-MM-dd').format(fromDate!) : '',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.clear, color: Color(0xFFC69840)),
              onPressed: () {
                setState(() {
                  fromDate = null;
                });
              },
              tooltip: 'Clear from date',
            ),
          ],
        ),
        const SizedBox(height: 10),
        // To Date field
        Row(
          children: [
            Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'to_date'.tr(),
                  labelStyle: TextStyle(color: const Color(0xFFC69840)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: const Color(0xFFC69840)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(color: const Color(0xFFC69840)),
                  ),
                  suffixIcon: Icon(Icons.calendar_today, color: const Color(0xFFC69840)),
                ),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    helpText: 'Select to date',
                  );
                  if (selectedDate != null) {
                    setState(() {
                      toDate = selectedDate;
                    });
                  }
                },
                controller: TextEditingController(
                  text: toDate != null ? DateFormat('yyyy-MM-dd').format(toDate!) : '',
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.clear, color: Color(0xFFC69840)),
              onPressed: () {
                setState(() {
                  toDate = null;
                });
              },
              tooltip: 'Clear to date',
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Apply Filters button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              widget.onApplyFilters(
                blockNoController.text,
                streetNoController.text,
                fromDate,
                toDate,
              );
            },
            child: Text('apply_filters'.tr(), style: const TextStyle(fontSize: 16.0)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC69840),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    blockNoController.dispose();
    streetNoController.dispose();
    super.dispose();
  }
}
