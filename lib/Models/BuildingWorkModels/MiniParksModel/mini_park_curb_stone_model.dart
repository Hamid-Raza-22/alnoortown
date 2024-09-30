class MiniParkCurbStoneModel{
  int? id;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String? mini_park_curbstone_comp_status;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted

  MiniParkCurbStoneModel({
    this.id,
    this.start_date,
    this.expected_comp_date,
    this.mini_park_curbstone_comp_status,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MiniParkCurbStoneModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MiniParkCurbStoneModel(
        id: json['id'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        mini_park_curbstone_comp_status:json['mini_park_curbstone_comp_status'],
        date:  json['mini_park_curbstone_date'],
        time:  json['time'],
        user_id: json['user_id'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'mini_park_curbstone_comp_status':mini_park_curbstone_comp_status,
      'mini_park_curbstone_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status

    };
  }
}
