
class ExcavationModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic length;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  ExcavationModel({
    this.id,
    this.block_no,
    this.street_no,
    this.length,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory ExcavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ExcavationModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
      length: json['length'],
        date:  json['excavation_work_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'street_no':street_no,
      'length':length,
      'excavation_work_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
