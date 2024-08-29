class AttendanceOutModel{
  int? id;
  dynamic timeOut;
  dynamic latitude;
  dynamic longitude;
  dynamic addressOut;
  dynamic date;

  AttendanceOutModel({
    this.id,
    this.timeOut,
    this.latitude,
    this.longitude,
    dynamic addressOut,
    this.date
  });

  factory AttendanceOutModel.fromMap(Map<dynamic,dynamic>json)
  {
    return AttendanceOutModel(
        id: json['id'],
        timeOut: json['timeOut'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        addressOut: json['addressOut'],
        date:  json['date']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'timeIn':timeOut,
      'latitude':latitude,
      'longitude':longitude,
      'liveAddress':addressOut,
      'date':date

    };
  }
}
