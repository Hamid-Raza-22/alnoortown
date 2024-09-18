import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  final Function(DateTime? fromDate, DateTime? toDate, String? block) onFilter;

  FilterWidget({required this.onFilter});

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  DateTime? selectedFromDate;
  DateTime? selectedToDate;
  String? selectedBlock;

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
                child: _buildDateField(context, selectedFromDate, (date) {
                  setState(() {
                    selectedFromDate = date;
                  });
                }, "From"),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDateField(context, selectedToDate, (date) {
                  setState(() {
                    selectedToDate = date;
                  });
                }, "To"),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search By Block',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC69840), width: 1.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC69840), width: 2.0),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
            ),
            onChanged: (value) {
              setState(() {
                selectedBlock = value;
              });
            },
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                widget.onFilter(selectedFromDate, selectedToDate, selectedBlock);
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

  Widget _buildDateField(BuildContext context, DateTime? selectedDate, Function(DateTime?) onDateSelected, String placeholder) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDialog<DateTime?>(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                height: 320,
                width: 280,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Color(0xFFC69840),
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFFC69840),
                      ),
                    ),
                    dialogBackgroundColor: Colors.white,
                  ),
                  child: CalendarDatePicker(
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    onDateChanged: (date) {
                      Navigator.pop(context, date);
                    },
                  ),
                ),
              ),
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
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC69840), width: 2.0),
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

