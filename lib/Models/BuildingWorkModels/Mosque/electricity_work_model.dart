class ElectricityWorkModel{
  int? id;
  dynamic blockNo;
  dynamic electricityWorkStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  ElectricityWorkModel({
    this.id,
    this.blockNo,
    this.electricityWorkStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)

  });

  factory ElectricityWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ElectricityWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        electricityWorkStatus: json['electricityWorkStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'electricityWorkStatus':electricityWorkStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
