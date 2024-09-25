class CeilingWorkModel{
  int? id;
  dynamic block_no;
  dynamic ceiling_work_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  CeilingWorkModel({
    this.id,
    this.block_no,
    this.ceiling_work_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory CeilingWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return CeilingWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        ceiling_work_status: json['ceiling_work_status'],
        date:  json['ceiling_work_date'],
        time:  json['time'],
      posted: json['posted']??0 // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'ceiling_work_status':ceiling_work_status,
      'ceiling_work_date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
