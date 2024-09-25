class ShiftingWorkModel{
  int? id;
  dynamic fromBlock;
  dynamic toBlock;
  dynamic numOfShift;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  ShiftingWorkModel({
    this.id,
    this.fromBlock,
    this.toBlock,
    this.numOfShift,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory ShiftingWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ShiftingWorkModel(
      id: json['id'],
      fromBlock: json['fromBlock'],
      toBlock: json['toBlock'],
      numOfShift: json['numOfShift'],
        date:  json['material_shifting_date'],
        time:  json['time'],
      posted: json['posted']??0 // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'fromBlock':fromBlock,
      'toBlock':toBlock,
      'numOfShift':numOfShift,
      'material_shifting_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
