class IronWorksModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic completedLength;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  IronWorksModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.completedLength,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory IronWorksModel.fromMap(Map<dynamic,dynamic>json)
  {
    return IronWorksModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      completedLength: json['completedLength'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'completedLength':completedLength,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
