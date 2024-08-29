class GazeboWorkModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic gazeboWorkCompStatus;


  GazeboWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.gazeboWorkCompStatus,

  });

  factory GazeboWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return GazeboWorkModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        gazeboWorkCompStatus:json['gazeboWorkCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'gazeboWorkCompStatus':gazeboWorkCompStatus,


    };
  }
}
