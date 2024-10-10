class AttendanceOutModel{
  int? id;
  dynamic time_out;
  dynamic user_id;
  dynamic latitude;
  dynamic longitude;
  dynamic address_out;
  dynamic date;

  AttendanceOutModel({
    this.id,
    this.time_out,
    this.latitude,
    this.longitude,
    this.address_out,
    this.user_id,
    this.date
  });

  factory AttendanceOutModel.fromMap(Map<dynamic,dynamic>json)
  {
    return AttendanceOutModel(
        id: json['id'],
        time_out: json['time_out'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        address_out: json['address_out'],
        user_id: json['user_id'],
        date:  json['attendance_out_date']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'time_out':time_out,
      'latitude':latitude,
      'longitude':longitude,
      'address_out':address_out,
      'user_id':user_id,
      'attendance_out_date':date

    };
  }
}
