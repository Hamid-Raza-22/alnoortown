class DoorsWorkModel{
  int? id;
  dynamic blockNo;
  dynamic doorsWorkStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  DoorsWorkModel({
    this.id,
    this.blockNo,
    this.doorsWorkStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory DoorsWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return DoorsWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        doorsWorkStatus: json['doorsWorkStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'doorsWorkStatus':doorsWorkStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
