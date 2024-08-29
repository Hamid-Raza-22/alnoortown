class RoadsSignBoardsModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic fromPlotNo;
  dynamic toPlotNo;
  dynamic roadSide;
  dynamic compStatus;

  RoadsSignBoardsModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.fromPlotNo,
    this.toPlotNo,
    this.roadSide,
    this.compStatus,

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
        compStatus:json['compStatus']
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


    };
  }
}
