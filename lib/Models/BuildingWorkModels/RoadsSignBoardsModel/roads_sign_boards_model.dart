class RoadsSignBoardsModel{
  int? id;
  String? blockNo;
  String? roadNo;
  String? fromPlotNo;
  String? toPlotNo;
  String? roadSide;
  String? compStatus;
  dynamic date;
  dynamic time;
  RoadsSignBoardsModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.fromPlotNo,
    this.toPlotNo,
    this.roadSide,
    this.compStatus,
    this.date,
    this.time
  });

  factory RoadsSignBoardsModel.fromMap(Map<dynamic,dynamic>json)
  {
    return RoadsSignBoardsModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        fromPlotNo: json['fromPlotNo'],
        toPlotNo: json['toPlotNo'],
        roadSide: json['roadSide'],
        compStatus:json['compStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'roadNo':roadNo,
      'fromPlotNo':fromPlotNo,
      'toPlotNo':toPlotNo,
      'roadSide':roadSide,
      'compStatus':compStatus,
      'date':date,
      'time':time,
    };
  }
}
