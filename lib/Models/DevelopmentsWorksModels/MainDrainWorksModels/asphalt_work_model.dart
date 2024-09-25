class AsphaltWorkModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic numOfTons;
  dynamic backFillingStatus;
  dynamic date;
  dynamic time;
  int posted;  // New field to track whether data has been posted

  AsphaltWorkModel({
    this.id,
    this.block_no,
    this.street_no,
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
      block_no: json['block_no'],
      street_no: json['street_no'],
      numOfTons: json['numOfTons'],
      backFillingStatus: json['backFillingStatus'],
        date:  json['asphalt_work_date'],
        time:  json['time'],
      posted: json['posted']??0  // Get the posted status from the database


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'block_no':block_no,
      'numOfTons':numOfTons,
      'street_no':street_no,
      'backFillingStatus':backFillingStatus,
      'asphalt_work_date':date,
      'time':time,
      'posted': posted,  // Include the posted status

    };
  }
}
