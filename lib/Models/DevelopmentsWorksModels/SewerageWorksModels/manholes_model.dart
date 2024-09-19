
class ManholesModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic noOfManholes;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted


  ManholesModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.noOfManholes,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)


  });

  factory ManholesModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ManholesModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
        noOfManholes: json['noOfManholes'],
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
      'noOfManholes':noOfManholes,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
