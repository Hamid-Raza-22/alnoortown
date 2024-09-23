
class BackFilingModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  BackFilingModel({
    this.id,
    this.block_no,
    this.street_no,
    this.status,
    this.date,
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
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'street_no':street_no,
      'status':status,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
