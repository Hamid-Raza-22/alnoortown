class MainGateFoundationWorkModel{
  int? id;
  dynamic block_no;
  dynamic workStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MainGateFoundationWorkModel ({
    this.id,
    this.block_no,
    this.workStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)


  });

  factory MainGateFoundationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainGateFoundationWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        workStatus: json['workStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'workStatus':workStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
