class SanitaryWorkModel{
  int? id;
  dynamic blockNo;
  dynamic sanitaryWorkStatus;
  dynamic date;



  SanitaryWorkModel({
    this.id,
    this.blockNo,
    this.sanitaryWorkStatus,
    this.date


  });

  factory SanitaryWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SanitaryWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        sanitaryWorkStatus: json['sanitaryWorkStatus'],
        date:  json['date']


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'sanitaryWorkStatus':sanitaryWorkStatus,
      'date':date

    };
  }
}
