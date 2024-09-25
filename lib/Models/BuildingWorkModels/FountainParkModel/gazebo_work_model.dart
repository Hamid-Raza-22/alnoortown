class GazeboWorkModel{
  int? id;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String?  gazebo_work_comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  GazeboWorkModel({
    this.id,
    this.start_date,
    this.expected_comp_date,
    this.gazebo_work_comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)


  });

  factory GazeboWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return GazeboWorkModel(
        id: json['id'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        gazebo_work_comp_status:json['gazebo_work_comp_status'],
        date:  json['gazebo_work_date'],
        time:  json['time'],
        posted: json['posted']?? 0
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'gazebo_work_comp_status':gazebo_work_comp_status,
      'gazebo_work_date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
