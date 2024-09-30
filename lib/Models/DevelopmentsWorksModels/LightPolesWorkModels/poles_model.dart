class PolesModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic no_of_poles;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted

  PolesModel({
    this.id,
    this.block_no,
    this.street_no,
    this.no_of_poles,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,  // Default to 0 (not posted)
  });

  factory PolesModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PolesModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
        no_of_poles: json['no_of_poles'],
        date:  json['poles_date'],
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
      'no_of_poles':no_of_poles,
      'poles_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status
    };
  }
}
