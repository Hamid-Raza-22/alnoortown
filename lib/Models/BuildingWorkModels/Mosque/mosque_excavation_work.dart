class MosqueExcavationWorkModel{
  int? id;
  dynamic blockNo;
  dynamic completionStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MosqueExcavationWorkModel({
    this.id,
    this.blockNo,
    this.completionStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MosqueExcavationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MosqueExcavationWorkModel(
      id: json['id'],
      blockNo: json['blockNo'],
      completionStatus: json['completionStatus'],
        date:  json['date'],
        time: json['time'],
      posted: json['posted'],  // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'completionStatus':completionStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
