class LightWiresModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic total_length;
  dynamic light_wire_work_status;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted

  LightWiresModel({
    this.id,
    this.block_no,
    this.street_no,
    this.total_length,
    this.light_wire_work_status,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory LightWiresModel.fromMap(Map<dynamic,dynamic>json)
  {
    return LightWiresModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
      total_length: json['total_length'],
        light_wire_work_status: json['light_wire_work_status'],
        date:  json['light_wire_date'],
        time:  json['time'],
        user_id: json['user_id'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'street_no':street_no,
      'total_length':total_length,
      'light_wire_work_status':light_wire_work_status,
      'light_wire_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status

    };
  }
}
