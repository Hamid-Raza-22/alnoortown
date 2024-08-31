class TilesWorkModel{
  int? id;
  dynamic blockNo;
  dynamic tilesWorkStatus;
  dynamic date;
  dynamic time;

  TilesWorkModel({
    this.id,
    this.blockNo,
    this.tilesWorkStatus,
    this.date,
    this.time
  });

  factory TilesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return TilesWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        tilesWorkStatus: json['tilesWorkStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'tilesWorkStatus':tilesWorkStatus,
      'date':date,
      'time':time,

    };
  }
}
