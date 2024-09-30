class AttendanceInModel{
  int? id;
  dynamic time_in;
  dynamic latitude;
  dynamic longitude;
  dynamic live_address;
  dynamic date;

  AttendanceInModel({
    this.id,
    this.time_in,
    this.latitude,
    this.longitude,
    this. live_address,
    this.date
  });

  factory AttendanceInModel.fromMap(Map<dynamic,dynamic>json)
  {
    return AttendanceInModel(
        id: json['id'],
        time_in: json['time_in'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        live_address: json['live_address'],
        date:  json['attendance_in_date']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'time_in':time_in,
      'latitude':latitude,
      'longitude':longitude,
      'live_address':live_address,
      'attendance_in_date':date

    };
  }
}
