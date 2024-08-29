class WalkingTracksWorkModel{
  int? id;
  dynamic typeOfWork;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic walkingTracksCompStatus;


  WalkingTracksWorkModel({
    this.id,
    this.typeOfWork,
    this.startDate,
    this.expectedCompDate,
    this.walkingTracksCompStatus,

  });

  factory WalkingTracksWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return WalkingTracksWorkModel(
        id: json['id'],
        typeOfWork: json['typeOfWork'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        walkingTracksCompStatus:json['walkingTracksCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'typeOfWork':typeOfWork,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'walkingTracksCompStatus':walkingTracksCompStatus,


    };
  }
}
