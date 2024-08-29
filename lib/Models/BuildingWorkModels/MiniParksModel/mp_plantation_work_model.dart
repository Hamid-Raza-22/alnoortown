class MpPlantationWorkModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic mpPCompStatus;


  MpPlantationWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mpPCompStatus,

  });

  factory MpPlantationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MpPlantationWorkModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        mpPCompStatus:json['mpPCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'mpPCompStatus':mpPCompStatus,


    };
  }
}
