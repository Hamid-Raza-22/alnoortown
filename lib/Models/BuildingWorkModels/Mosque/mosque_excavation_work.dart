class MosqueExcavationWorkModel{
  int? id;
  dynamic block_no;
  dynamic completionStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MosqueExcavationWorkModel({
    this.id,
    this.block_no,
    this.completionStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MosqueExcavationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MosqueExcavationWorkModel(
      id: json['id'],
      block_no: json['block_no'],
      completionStatus: json['completionStatus'],
        date:  json['mosque_excavation_date'],
        time: json['time'],
      posted: json['posted']??0  // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'completionStatus':completionStatus,
      'mosque_excavation_date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
