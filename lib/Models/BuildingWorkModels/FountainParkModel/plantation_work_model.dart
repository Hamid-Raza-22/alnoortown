class PlantationWorkModel{
  int? id;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String? plantation_comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted
  PlantationWorkModel({
    this.id,
    this.start_date,
    this.expected_comp_date,
    this.plantation_comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)
  });

  factory PlantationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PlantationWorkModel(
        id: json['id'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        plantation_comp_status:json['plantation_comp_status'],
        date:  json['plantation_work_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'plantation_comp_status':plantation_comp_status,
      'plantation_work_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
