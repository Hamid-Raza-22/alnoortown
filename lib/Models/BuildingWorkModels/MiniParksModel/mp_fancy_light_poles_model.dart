class MpFancyLightPolesModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic mpLCompStatus;


  MpFancyLightPolesModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mpLCompStatus,

  });

  factory MpFancyLightPolesModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MpFancyLightPolesModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        mpLCompStatus:json['mpLCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'mpLCompStatus':mpLCompStatus,


    };
  }
}
