class TilesWorkModel{
  int? id;
  dynamic block_no;
  dynamic tilesWorkStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  TilesWorkModel({
    this.id,
    this.block_no,
    this.tilesWorkStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory TilesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return TilesWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        tilesWorkStatus: json['tilesWorkStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'tilesWorkStatus':tilesWorkStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
