class CubStonesWorkModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic cubStonesCompStatus;


  CubStonesWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.cubStonesCompStatus,

  });

  factory CubStonesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return CubStonesWorkModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        cubStonesCompStatus:json['cubStonesCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'cubStonesCompStatus':cubStonesCompStatus,


    };
  }
}
