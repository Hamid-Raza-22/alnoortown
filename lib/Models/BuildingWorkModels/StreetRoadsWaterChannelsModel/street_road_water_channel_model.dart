class StreetRoadWaterChannelModel{
  int? id;
  dynamic blockNo;
  dynamic roadNo;
  dynamic roadSide;
  dynamic noOfWaterChannels;
  dynamic waterChCompStatus;
  dynamic date;

  StreetRoadWaterChannelModel({
    this.id,
    this.blockNo,
    this.roadNo,
    this.roadSide,
    this.noOfWaterChannels,
    this.waterChCompStatus,
    this.date,

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
      date: json['date'],
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



    };
  }
}
