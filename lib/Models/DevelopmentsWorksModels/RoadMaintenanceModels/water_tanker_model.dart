class WaterTankerModel{
  int? id;
  dynamic block_no;
  dynamic street_no;
  dynamic tanker_no;
  dynamic date;
  dynamic time;
  int posted;
  dynamic user_id;
  WaterTankerModel ({
    this.id,
    this.block_no,
    this.street_no,
    this.tanker_no,
    this.date,
    this.time,
    this.user_id,
    this.posted = 0
  });

  factory WaterTankerModel.fromMap(Map<dynamic,dynamic>json)
  {
    return WaterTankerModel(
      id: json['id'],
      block_no: json['block_no'],
      street_no: json['street_no'],
      tanker_no: json['tanker_no'],
        date:  json['water_tanker_date'],
        time:  json['time'],
        user_id: json['user_id'],
      posted: json['posted']?? 0
    );
  }

  Map<String, dynamic> toMap(){
    return {
     'id':id,
      'block_no':block_no,
      'street_no':street_no,
      'tanker_no':tanker_no,
      'water_tanker_date':date,
      'time':time,
      'user_id':user_id,
       'posted':posted
    };
  }
}
