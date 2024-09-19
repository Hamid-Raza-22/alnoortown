class LightWiresModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic totalLength;
  dynamic lightWireWorkStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  LightWiresModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.totalLength,
    this.lightWireWorkStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory LightWiresModel.fromMap(Map<dynamic,dynamic>json)
  {
    return LightWiresModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      totalLength: json['totalLength'],
        lightWireWorkStatus: json['lightWireWorkStatus'],
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
      'totalLength':totalLength,
      'lightWireWorkStatus':lightWireWorkStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
