class MgGreyStructureModel{
  int? id;
  dynamic block_no;
  dynamic work_status;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MgGreyStructureModel ({
    this.id,
    this.block_no,
    this.work_status,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MgGreyStructureModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MgGreyStructureModel(
        id: json['id'],
        block_no: json['block_no'],
        work_status: json['work_status'],
        date:  json['main_gate_grey_structure_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'work_status':work_status,
      'main_gate_grey_structure_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
