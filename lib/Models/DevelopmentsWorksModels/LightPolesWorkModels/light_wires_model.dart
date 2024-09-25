class LightWiresModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic totalLength;
  dynamic lightWireWorkStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  LightWiresModel({
    this.id,
    this.block_no,
    this.street_no,
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
      block_no: json['block_no'],
      street_no: json['street_no'],
      totalLength: json['totalLength'],
        lightWireWorkStatus: json['lightWireWorkStatus'],
        date:  json['light_wires_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'street_no':street_no,
      'totalLength':totalLength,
      'lightWireWorkStatus':lightWireWorkStatus,
      'light_wires_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
