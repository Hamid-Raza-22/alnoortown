class MonumentsWorkModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic monumentsWorkCompStatus;


  MonumentsWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.monumentsWorkCompStatus,

  });

  factory MonumentsWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MonumentsWorkModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        monumentsWorkCompStatus:json['monumentsWorkCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'monumentsWorkCompStatus':monumentsWorkCompStatus,


    };
  }
}
