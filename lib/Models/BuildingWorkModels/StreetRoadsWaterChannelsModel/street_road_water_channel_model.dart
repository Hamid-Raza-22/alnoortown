class StreetRoadWaterChannelModel{
  int? id;
  String?  block_no;
  String? road_no;
  String? road_side;
  String? no_of_water_channels;
  String? water_channels_comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  StreetRoadWaterChannelModel({
    this.id,
    this.block_no,
    this.road_no,
    this.road_side,
    this.no_of_water_channels,
    this.water_channels_comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory StreetRoadWaterChannelModel.fromMap(Map<dynamic,dynamic>json)
  {
    return StreetRoadWaterChannelModel(
      id: json['id'],
      block_no: json['block_no'],
      road_no: json['road_no'],
      road_side: json['road_side'],
      no_of_water_channels: json['no_of_water_channels'],
      water_channels_comp_status: json['water_channels_comp_status'],
        date:  json['street_roads_water_channel_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'road_no':road_no,
      'road_side':road_side,
      'no_of_water_channels':no_of_water_channels,
      'water_channels_comp_status':water_channels_comp_status,
      'street_roads_water_channel_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
