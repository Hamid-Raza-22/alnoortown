class RoadCurbStonesWorkModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic totalLength;
  dynamic compStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  RoadCurbStonesWorkModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.totalLength,
    this.compStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)


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
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

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
      'posted': posted,  // Include the posted status

    };
  }
}
