class FoundationWorkModel{
  int? id;
  dynamic block_no;
  dynamic brickWork;
  dynamic mudFiling;
  dynamic plasterWork;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  FoundationWorkModel({
    this.id,
    this.block_no,
    this.brickWork,
    this.mudFiling,
    this.plasterWork,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)


  });

  factory FoundationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return FoundationWorkModel(
        id: json['id'],
        block_no: json['block_no'],
        brickWork: json['brickWork'],
        mudFiling: json['mudFiling'],
        plasterWork: json['plasterWork'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'brickWork':brickWork,
      'mudFiling':mudFiling,
      'plasterWork':plasterWork,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status


    };
  }
}
