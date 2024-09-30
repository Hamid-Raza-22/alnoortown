class SittingAreaWorkModel {
  int? id;
  String? type_of_work;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String? sitting_area_comp_status;
  String? block;  // New field for block
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted

  SittingAreaWorkModel({
    this.id,
    this.type_of_work,
    this.start_date,
    this.expected_comp_date,
    this.sitting_area_comp_status,
    this.block,  // Include block in constructor
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,  // Default to 0 (not posted)
  });

  factory SittingAreaWorkModel.fromMap(Map<dynamic, dynamic> json) {
    return SittingAreaWorkModel(
      id: json['id'],
      type_of_work: json['type_of_work'],
      start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
      expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
      sitting_area_comp_status: json['sitting_area_comp_status'],
      block: json['block'],  // Fetch block from JSON
      date: json['sitting_area_date'],
      time: json['time'],
      user_id: json['user_id'],
      posted: json['posted'] ?? 0,  // Get the posted status from the database
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type_of_work': type_of_work,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'sitting_area_comp_status': sitting_area_comp_status,
      'block': block,  // Include block in the map
      'sitting_area_date': date,
      'time': time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status
    };
  }
}
