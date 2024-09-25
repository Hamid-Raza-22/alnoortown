class DoorsWorkModel{
  int? id;
  dynamic block_no;
  dynamic doorsWorkStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  DoorsWorkModel({
    this.id,
    this.block_no,
    this.doorsWorkStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory DoorsWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return DoorsWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        doorsWorkStatus: json['doorsWorkStatus'],
        date:  json['doors_work_date'],
        time:  json['time'],
      posted: json['posted']??0 // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'doorsWorkStatus':doorsWorkStatus,
      'doors_work_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
