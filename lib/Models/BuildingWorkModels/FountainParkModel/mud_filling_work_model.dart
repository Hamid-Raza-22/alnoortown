class MudFillingWorkModel {
  int? id;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String? total_dumpers;
  String? mud_filling_comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MudFillingWorkModel({
    this.id,
    this.start_date,
    this.expected_comp_date,
    this.total_dumpers,
    this.mud_filling_comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)
  });

  factory MudFillingWorkModel.fromMap(Map<dynamic, dynamic> json) {
    return MudFillingWorkModel(
      id: json['id'],
      start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
      total_dumpers: json['total_dumpers'],
      mud_filling_comp_status: json['mud_filling_comp_status'],
        date:  json['mud_filling_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'total_dumpers': total_dumpers,
      'mud_filling_comp_status': mud_filling_comp_status,
      'mud_filling_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
