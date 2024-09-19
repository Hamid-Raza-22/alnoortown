class StreetRoadWaterChannelModel{
  int? id;
  String?  blockNo;
  String? roadNo;
  String? roadSide;
  String? noOfWaterChannels;
  String? waterChCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  StreetRoadWaterChannelModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.roadSide,
    this.noOfWaterChannels,
    this.waterChCompStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory StreetRoadWaterChannelModel.fromMap(Map<dynamic,dynamic>json)
  {
    return StreetRoadWaterChannelModel(
      id: json['id'],
      blockNo: json['blockNo'],
      roadNo: json['roadNo'],
      roadSide: json['roadSide'],
      noOfWaterChannels: json['noOfWaterChannels'],
      waterChCompStatus: json['waterChCompStatus'],
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
      'roadSide':roadSide,
      'noOfWaterChannels':noOfWaterChannels,
      'waterChCompStatus':waterChCompStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
