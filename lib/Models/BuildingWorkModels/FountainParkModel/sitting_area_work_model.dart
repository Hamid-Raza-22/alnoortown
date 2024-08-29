class SittingAreaWorkModel{
  int? id;
  dynamic typeOfWork;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic sittingAreaCompStatus;


  SittingAreaWorkModel({
    this.id,
    this.typeOfWork,
    this.startDate,
    this.expectedCompDate,
    this.sittingAreaCompStatus,

  });

  factory SittingAreaWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return SittingAreaWorkModel(
        id: json['id'],
        typeOfWork: json['typeOfWork'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        sittingAreaCompStatus:json['sittingAreaCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'typeOfWork':typeOfWork,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'sittingAreaCompStatus':sittingAreaCompStatus,


    };
  }
}
