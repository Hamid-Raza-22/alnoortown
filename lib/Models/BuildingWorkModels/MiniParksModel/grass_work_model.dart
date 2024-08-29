class GrassWorkModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic grassWorkCompStatus;


  GrassWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.grassWorkCompStatus,

  });

  factory GrassWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return GrassWorkModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        grassWorkCompStatus:json['grassWorkCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'grassWorkCompStatus':grassWorkCompStatus,


    };
  }
}
