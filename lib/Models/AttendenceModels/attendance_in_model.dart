class AttendanceInModel{
  int? id;
  dynamic timeIn;
  dynamic latitude;
  dynamic longitude;
  dynamic liveAddress;
  dynamic date;

  AttendanceInModel({
    this.id,
    this.timeIn,
    this.latitude,
    this.longitude,
    this. liveAddress,
    this.date

  });

  factory AttendanceInModel.fromMap(Map<dynamic,dynamic>json)
  {
    return AttendanceInModel(
        id: json['id'],
        timeIn: json['timeIn'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        liveAddress: json['liveAddress'],
        date:  json['date']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'timeIn':timeIn,
      'latitude':latitude,
      'longitude':longitude,
      'liveAddress':liveAddress,
      'date':date

    };
  }
}
