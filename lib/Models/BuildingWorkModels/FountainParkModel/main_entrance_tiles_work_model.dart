class MainEntranceTilesWorkModel{
  int? id;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String?  main_entrance_tiles_work_comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MainEntranceTilesWorkModel({
    this.id,
    this.start_date,
    this.expected_comp_date,
    this.main_entrance_tiles_work_comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MainEntranceTilesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainEntranceTilesWorkModel(
        id: json['id'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        main_entrance_tiles_work_comp_status:json['main_entrance_tiles_work_comp_status'],
        date:  json['main_entrance_tiles_date'],
        time:  json['time'],
      posted: json['posted']?? 0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'main_entrance_tiles_work_comp_status':main_entrance_tiles_work_comp_status,
      'main_entrance_tiles_date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
