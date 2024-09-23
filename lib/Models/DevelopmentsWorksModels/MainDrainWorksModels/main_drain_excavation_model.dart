class MainDrainExcavationModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic completedLength;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  MainDrainExcavationModel({
    this.id,
    this.block_no,
    this.street_no,
    this.completedLength,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory MainDrainExcavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainDrainExcavationModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
      completedLength: json['completedLength'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database



    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'street_no':street_no,
      'completedLength':completedLength,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
