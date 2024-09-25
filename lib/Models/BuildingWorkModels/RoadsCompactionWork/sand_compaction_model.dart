class SandCompactionModel{
  int? id;
  dynamic block_no;
  dynamic road_no;
  dynamic total_length;
  DateTime? start_date;
  DateTime? expected_comp_date;
  dynamic sand_comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  SandCompactionModel({
    this.id,
    this.block_no,
    this.road_no,
    this.total_length,
    this.start_date,
    this.expected_comp_date,
    this.sand_comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory SandCompactionModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SandCompactionModel(
        id: json['id'],
        block_no: json['block_no'],
        road_no: json['road_no'],
        total_length: json['total_length'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        sand_comp_status:json['sand_comp_status'],
        date:  json['sand_compaction_date'],
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
      'sand_comp_status':sand_comp_status,
      'sand_compaction_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
