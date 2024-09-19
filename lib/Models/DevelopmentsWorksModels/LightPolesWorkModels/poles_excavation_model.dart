class PolesExcavationModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic noOfExcavation;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  PolesExcavationModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.noOfExcavation,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory PolesExcavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PolesExcavationModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
        noOfExcavation: json['noOfExcavation'],
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
      'noOfExcavation':noOfExcavation,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
