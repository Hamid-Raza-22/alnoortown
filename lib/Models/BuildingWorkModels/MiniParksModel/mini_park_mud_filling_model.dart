class MiniParkMudFillingModel{
  int? id;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String? total_dumpers;
  String? mini_park_mud_filling_comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MiniParkMudFillingModel({
    this.id,
    this.start_date,
    this.expected_comp_date,
    this.total_dumpers,
    this.mini_park_mud_filling_comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MiniParkMudFillingModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MiniParkMudFillingModel(
        id: json['id'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        total_dumpers: json['total_dumpers'],
        mini_park_mud_filling_comp_status:json['mini_park_mud_filling_comp_status'],
        date:  json['mini_park_mud_filling_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'total_dumpers':total_dumpers,
      'mini_park_mud_filling_comp_status':mini_park_mud_filling_comp_status,
      'mini_park_mud_filling_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
