class RoadsEdgingWorkModel{
  int? id;
  String? block_no;
  String?  road_no;
  String?  road_side;
  String?  total_length;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String?  roads_edging_comp_status;
  dynamic date;
  dynamic user_id;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  RoadsEdgingWorkModel({
    this.id,
    this.block_no,
    this.road_no,
    this.road_side,
    this.total_length,
    this.start_date,
    this.expected_comp_date,
    this.roads_edging_comp_status,
    this.date,
    this.user_id,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)
  });

  factory RoadsEdgingWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return RoadsEdgingWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        road_no: json['road_no'],
        road_side: json['road_side'],
        total_length: json['total_length'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        roads_edging_comp_status:json['roads_edging_comp_status'],
        date:  json['roads_edging_date'],
        time:  json['time'],
        user_id: json['user_id'],
      posted: json['posted']??0// Get the posted status from the database
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'road_no':road_no,
      'road_side':road_side,
      'total_length':total_length,
      'start_date': start_date?.toString(),
      'expected_comp_date': expected_comp_date?.toString(),
      'roads_edging_comp_status':roads_edging_comp_status,
      'roads_edging_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status
    };
  }
}
