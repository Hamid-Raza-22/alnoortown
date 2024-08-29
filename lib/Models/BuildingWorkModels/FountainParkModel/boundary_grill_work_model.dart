class BoundaryGrillWorkModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic boundaryWorkCompStatus;


  BoundaryGrillWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.boundaryWorkCompStatus,

  });

  factory BoundaryGrillWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return BoundaryGrillWorkModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        boundaryWorkCompStatus:json['boundaryWorkCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'boundaryWorkCompStatus':boundaryWorkCompStatus,


    };
  }
}
