
class BackFilingModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic status;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted

  BackFilingModel({
    this.id,
    this.block_no,
    this.street_no,
    this.status,
    this.date,
    this.user_id,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)
  });

  factory BackFilingModel.fromMap(Map<dynamic,dynamic>json)
  {
    return BackFilingModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
        status: json['status'],
        date:  json['back_filling_date'],
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
      'status':status,
      'back_filling_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status

    };
  }
}
