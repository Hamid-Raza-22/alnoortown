class MonumentsWorkModel{
  int? id;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String?  monuments_work_comp_status;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;

  MonumentsWorkModel({
    this.id,
    this.start_date,
    this.expected_comp_date,
    this.monuments_work_comp_status,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,
  });

  factory MonumentsWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MonumentsWorkModel(
        id: json['id'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        monuments_work_comp_status:json['monuments_work_comp_status'],
        date:  json['monuments_date'],
        time:  json['time'],
        user_id: json['user_id'],
      posted: json['posted']??0 // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'monuments_work_comp_status':monuments_work_comp_status,
      'monuments_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status

    };
  }
}
