class RoadCurbStonesWorkModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic totalLength;
  dynamic compStatus;
  dynamic date;
  dynamic time;

  RoadCurbStonesWorkModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.totalLength,
    this.compStatus,
    this.date,
    this.time

  });

  factory RoadCurbStonesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return RoadCurbStonesWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        roadNo: json['roadNo'],
        totalLength: json['totalLength'],
        compStatus: json['compStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'roadNo':roadNo,
      'totalLength':totalLength,
      'compStatus':compStatus,
      'date':date,
      'time':time,

    };
  }
}
