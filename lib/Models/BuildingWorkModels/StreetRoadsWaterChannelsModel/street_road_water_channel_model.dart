class StreetRoadWaterChannelModel{
  int? id;
  String?  blockNo;
  String? roadNo;
  String? roadSide;
  String? noOfWaterChannels;
  String? waterChCompStatus;
  dynamic date;
  dynamic time;

  StreetRoadWaterChannelModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.roadSide,
    this.noOfWaterChannels,
    this.waterChCompStatus,
    this.date,
    this.time
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
        time:  json['time']
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

    };
  }
}
