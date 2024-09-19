class MgPlasterWorkModel{
  int? id;
  dynamic blockNo;
  dynamic workStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MgPlasterWorkModel ({
    this.id,
    this.blockNo,
    this.workStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MgPlasterWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MgPlasterWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        workStatus: json['workStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'workStatus':workStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
