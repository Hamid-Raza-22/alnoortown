class ShutteringWorkModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic completed_length;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted

  ShutteringWorkModel({
    this.id,
    this.block_no,
    this.street_no,
    this.completed_length,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory ShutteringWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ShutteringWorkModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
      completed_length: json['completed_length'],
        date:  json['shuttering_work_date'],
        time:  json['time'],
        user_id: json['user_id'],
      posted: json['posted']??0 // Get the posted status from the database
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'street_no':street_no,
      'completed_length':completed_length,
      'shuttering_work_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status

    };
  }
}
