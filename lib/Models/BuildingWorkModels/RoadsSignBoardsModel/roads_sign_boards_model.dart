class RoadsSignBoardsModel{
  int? id;
  String? block_no;
  String? roadNo;
  String? fromPlotNo;
  String? toPlotNo;
  String? roadSide;
  String? compStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  RoadsSignBoardsModel({
    this.id,
    this.block_no,
    this.roadNo,
    this.fromPlotNo,
    this.toPlotNo,
    this.roadSide,
    this.compStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory RoadsSignBoardsModel.fromMap(Map<dynamic,dynamic>json)
  {
    return RoadsSignBoardsModel(
        id: json['id'],
        block_no: json['block_no'],
        roadNo: json['roadNo'],
        fromPlotNo: json['fromPlotNo'],
        toPlotNo: json['toPlotNo'],
        roadSide: json['roadSide'],
        compStatus:json['compStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'roadNo':roadNo,
      'fromPlotNo':fromPlotNo,
      'toPlotNo':toPlotNo,
      'roadSide':roadSide,
      'compStatus':compStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
