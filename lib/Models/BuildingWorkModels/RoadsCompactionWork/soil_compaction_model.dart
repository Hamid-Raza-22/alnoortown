class SoilCompactionModel{
  int? id;
  String? block_no;
  String? road_no;
  String?  total_length;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String?  soil_comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  SoilCompactionModel({
    this.id,
    this.block_no,
    this.road_no,
    this.total_length,
    this.start_date,
    this.expected_comp_date,
    this.soil_comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory SoilCompactionModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SoilCompactionModel(
        id: json['id'],
        block_no: json['block_no'],
        road_no: json['road_no'],
        total_length: json['total_length'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        soil_comp_status:json['soil_comp_status'],
        date:  json['soil_compaction_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'road_no':road_no,
      'total_length':total_length,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'soil_comp_status':soil_comp_status,
      'soil_compaction_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
