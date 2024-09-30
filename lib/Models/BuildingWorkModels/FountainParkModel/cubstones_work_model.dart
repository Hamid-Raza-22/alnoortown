class CubStonesWorkModel{
  int? id;
  dynamic start_date;
  dynamic expected_comp_date;
  String?  curbstones_comp_status;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted
  CubStonesWorkModel({
    this.id,
    this.start_date,
    this.expected_comp_date,
    this.curbstones_comp_status,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,  // Default to 0 (not posted)
  });

  factory CubStonesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return CubStonesWorkModel(
        id: json['id'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        curbstones_comp_status:json['curbstones_comp_status'],
        date:  json['curbstones_work_date'],
        time:  json['time'],
        user_id: json['user_id'],
        posted: json['posted']?? 0
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'curbstones_comp_status':curbstones_comp_status,
      'curbstones_work_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status
    };
  }
}
