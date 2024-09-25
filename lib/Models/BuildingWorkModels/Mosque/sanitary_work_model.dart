class SanitaryWorkModel{
  int? id;
  dynamic block_no;
  dynamic sanitaryWorkStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  SanitaryWorkModel({
    this.id,
    this.block_no,
    this.sanitaryWorkStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory SanitaryWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SanitaryWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        sanitaryWorkStatus: json['sanitaryWorkStatus'],
        date:  json['sanitary_work_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'sanitaryWorkStatus':sanitaryWorkStatus,
      'sanitary_work_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
