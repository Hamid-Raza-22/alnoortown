class RoadCurbStonesWorkModel{
  int? id;
  dynamic block_no;
  dynamic road_no;
  dynamic total_length;
  dynamic comp_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  RoadCurbStonesWorkModel({
    this.id,
    this.block_no,
    this.road_no,
    this.total_length,
    this.comp_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)


  });

  factory RoadCurbStonesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return RoadCurbStonesWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        road_no: json['road_no'],
        total_length: json['total_length'],
        comp_status: json['comp_status'],
        date:  json['roads_curbstone_date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'road_no':road_no,
      'total_length':total_length,
      'comp_status':comp_status,
      'roads_curbstone_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
