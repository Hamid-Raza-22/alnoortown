class BackFillingWsModel{
  int? id;
  String? block_no;
  String? road_no;
  String? road_side;
  String? total_length;
  DateTime? start_date;
  DateTime? expected_comp_date;
  String? water_supply_back_filling_comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  BackFillingWsModel({
    this.id,
    this.block_no,
    this.road_no,
    this.road_side,
    this.total_length,
    this.start_date,
    this.expected_comp_date,
    this.water_supply_back_filling_comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory BackFillingWsModel.fromMap(Map<dynamic,dynamic>json)
  {
    return BackFillingWsModel(
        id: json['id'],
        block_no: json['block_no'],
        road_no: json['road_no'],
        road_side: json['road_side'],
        total_length: json['total_length'],
        start_date: json['start_date'] != null ? DateTime.parse(json['start_date']) : null,
        expected_comp_date: json['expected_comp_date'] != null ? DateTime.parse(json['expected_comp_date']) : null,
        water_supply_back_filling_comp_status:json['water_supply_back_filling_comp_status'],
        date:  json['back_filling_water_supply_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

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
      'water_supply_back_filling_comp_status':water_supply_back_filling_comp_status,
      'back_filling_water_supply_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
