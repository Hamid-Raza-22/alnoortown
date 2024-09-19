
class ExcavationModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic length;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  ExcavationModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.length,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory ExcavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ExcavationModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      length: json['length'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'length':length,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
