class MgPlasterWorkModel{
  int? id;
  dynamic block_no;
  dynamic work_status;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted

  MgPlasterWorkModel ({
    this.id,
    this.block_no,
    this.work_status,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MgPlasterWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MgPlasterWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        work_status: json['work_status'],
        date:  json['main_gate_plaster_work_date'],
        time:  json['time'],
        user_id: json['user_id'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'work_status':work_status,
      'main_gate_plaster_work_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status

    };
  }
}
