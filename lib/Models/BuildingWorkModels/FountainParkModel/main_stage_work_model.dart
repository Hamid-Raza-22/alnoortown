class MainStageWorkModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic mainStageWorkCompStatus;


  MainStageWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mainStageWorkCompStatus,

  });

  factory MainStageWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainStageWorkModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        mainStageWorkCompStatus:json['mainStageWorkCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'mainStageWorkCompStatus':mainStageWorkCompStatus,


    };
  }
}
