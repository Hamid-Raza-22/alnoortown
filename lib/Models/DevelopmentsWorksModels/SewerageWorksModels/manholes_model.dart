
class ManholesModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic no_of_manholes;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  ManholesModel({
    this.id,
    this.block_no,
    this.street_no,
    this.no_of_manholes,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)
  });

  factory ManholesModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ManholesModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
        no_of_manholes: json['no_of_manholes'],
        date:  json['manholes_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'street_no':street_no,
      'no_of_manholes':no_of_manholes,
      'manholes_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
