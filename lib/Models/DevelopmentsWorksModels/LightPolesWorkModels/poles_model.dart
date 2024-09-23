class PolesModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic noOfPoles;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  PolesModel({
    this.id,
    this.block_no,
    this.street_no,
    this.noOfPoles,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory PolesModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PolesModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
        noOfPoles: json['noOfPoles'],
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
      'noOfPoles':noOfPoles,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
