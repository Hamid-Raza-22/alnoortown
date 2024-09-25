class FoundationWorkModel{
  int? id;
  dynamic block_no;
  dynamic brick_work;
  dynamic mud_filling;
  dynamic plaster_work;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  FoundationWorkModel({
    this.id,
    this.block_no,
    this.brick_work,
    this.mud_filling,
    this.plaster_work,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)


  });

  factory FoundationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return FoundationWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        brick_work: json['brick_work'],
        mud_filling: json['mud_filling'],
        plaster_work: json['plaster_work'],
        date:  json['foundation_work_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'brick_work':brick_work,
      'mud_filling':mud_filling,
      'plaster_work':plaster_work,
      'foundation_work_date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
