class ShiftingWorkModel{
  int? id;
  dynamic from_block;
  dynamic to_block;
  dynamic no_of_shift;
  dynamic date;
  dynamic time;
  dynamic user_id;
  int posted;  // New field to track whether data has been posted

  ShiftingWorkModel({
    this.id,
    this.from_block,
    this.to_block,
    this.no_of_shift,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory ShiftingWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ShiftingWorkModel(
      id: json['id'],
      from_block: json['from_block'],
      to_block: json['to_block'],
      no_of_shift: json['no_of_shift'],
        date:  json['shifting_work_date'],
        time:  json['time'],
        user_id: json['user_id'],
      posted: json['posted']??0 // Get the posted status from the database
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'from_block':from_block,
      'to_block':to_block,
      'no_of_shift':no_of_shift,
      'shifting_work_date':date,
      'time':time,
      'user_id':user_id,
      'posted': posted,  // Include the posted status

    };
  }
}
