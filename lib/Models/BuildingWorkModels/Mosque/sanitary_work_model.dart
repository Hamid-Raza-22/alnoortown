class SanitaryWorkModel{
  int? id;
  dynamic blockNo;
  dynamic sanitaryWorkStatus;
  dynamic date;
  dynamic time;

  SanitaryWorkModel({
    this.id,
    this.blockNo,
    this.sanitaryWorkStatus,
    this.date,
    this.time
  });

  factory SanitaryWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SanitaryWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        sanitaryWorkStatus: json['sanitaryWorkStatus'],
        date:  json['date'],
        time:  json['time']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'sanitaryWorkStatus':sanitaryWorkStatus,
      'date':date,
      'time':time,

    };
  }
}
