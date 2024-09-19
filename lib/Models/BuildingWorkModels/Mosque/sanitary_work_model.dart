class SanitaryWorkModel{
  int? id;
  dynamic blockNo;
  dynamic sanitaryWorkStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  SanitaryWorkModel({
    this.id,
    this.blockNo,
    this.sanitaryWorkStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory SanitaryWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SanitaryWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        sanitaryWorkStatus: json['sanitaryWorkStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'sanitaryWorkStatus':sanitaryWorkStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
