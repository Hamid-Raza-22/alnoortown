class StreetRoadWaterChannelModel{
  int? id;
  String?  block_no;
  String? roadNo;
  String? roadSide;
  String? noOfWaterChannels;
  String? waterChCompStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  StreetRoadWaterChannelModel({
    this.id,
    this.block_no,
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
      block_no: json['block_no'],
      roadNo: json['roadNo'],
      roadSide: json['roadSide'],
      noOfWaterChannels: json['noOfWaterChannels'],
      waterChCompStatus: json['waterChCompStatus'],
        date:  json['street_roads_water_channel_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'roadNo':roadNo,
      'roadSide':roadSide,
      'noOfWaterChannels':noOfWaterChannels,
      'waterChCompStatus':waterChCompStatus,
      'street_roads_water_channel_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
