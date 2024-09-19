class PolesModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic noOfPoles;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  PolesModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.noOfPoles,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory PolesModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PolesModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
        noOfPoles: json['noOfPoles'],
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
      'noOfPoles':noOfPoles,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
