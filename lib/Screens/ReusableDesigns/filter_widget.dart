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
      padding: EdgeInsets.all(8.0), // Reduced padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Range Filter Row (Compact)
          Row(
            children: [
              Expanded(
                child: _buildDateField(context, selectedFromDate, (date) {
                  setState(() {
                    selectedFromDate = date;
                  });
                }, "From"),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _buildDateField(context, selectedToDate, (date) {
                  setState(() {
                    selectedToDate = date;
                  });
                }, "To"),
              ),
            ],
          ),
          SizedBox(height: 8), // Reduced spacing

          // Block Input Field (Compact)
          TextField(
            decoration: InputDecoration(
              hintText: 'Search By Block',
              hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)), // Lighter opacity for placeholder
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC69840), width: 1.0), // Gold border
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFC69840), width: 2.0), // Thicker gold border when focused
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Compact size
            ),
            onChanged: (value) {
              setState(() {
                selectedBlock = value;
              });
            },
          ),
          SizedBox(height: 8), // Reduced spacing

          // Search Button
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Call the filter function with the selected dates and block (convert block to lowercase)
                widget.onFilter(selectedFromDate, selectedToDate, selectedBlock?.toLowerCase());
              },
              child: Text(
                "Search",
                style: TextStyle(color: Color(0xFFC69840)), // Gold color for text
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Simplified Date Field Builder with small-sized calendar
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
                height: 320, // Smaller height for the calendar
                width: 280,  // Smaller width for the calendar
                child: Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: ColorScheme.light(
                      primary: Color(0xFFC69840), // Gold color for the selected date
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Color(0xFFC69840), // Gold color for 'OK'/'Cancel' buttons
                      ),
                    ),
                    dialogBackgroundColor: Colors.white,
                  ),
                  child: CalendarDatePicker(
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                    onDateChanged: (date) {
                      Navigator.pop(context, date); // Close dialog when date selected
                    },
                    selectableDayPredicate: (date) => true, // Allow all days
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
          hintText: placeholder, // Placeholder (e.g., "From", "To")
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC69840), width: 1.0), // Gold border
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC69840), width: 2.0), // Thicker gold border when focused
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10), // Compact size
        ),
        child: Text(
          selectedDate != null
              ? "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"
              : placeholder,
          style: TextStyle(color: selectedDate != null ? Colors.black : Colors.grey[600]), // Update text color if date is selected
        ),
      ),
    );
  }
}
