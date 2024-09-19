class AsphaltWorkModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic numOfTons;
  dynamic backFillingStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  AsphaltWorkModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.numOfTons,
    this.backFillingStatus,
    this.date,
    this.time,
    this.posted = 0,  // Default to 0 (not posted)


  });

  factory AsphaltWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return AsphaltWorkModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      numOfTons: json['numOfTons'],
      backFillingStatus: json['backFillingStatus'],
        date:  json['date'],
        time:  json['time'],
      posted: json['posted'],  // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'numOfTons':numOfTons,
      'streetNo':streetNo,
      'backFillingStatus':backFillingStatus,
      'date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
