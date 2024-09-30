class AsphaltWorkModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic no_of_tons;
  dynamic back_filling_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  AsphaltWorkModel({
    this.id,
    this.block_no,
    this.street_no,
    this.no_of_tons,
    this.back_filling_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)
  });

  factory AsphaltWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return AsphaltWorkModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
      no_of_tons: json['no_of_tons'],
      back_filling_status: json['back_filling_status'],
        date:  json['asphalt_work_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'no_of_tons':no_of_tons,
      'street_no':street_no,
      'back_filling_status':back_filling_status,
      'asphalt_work_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
