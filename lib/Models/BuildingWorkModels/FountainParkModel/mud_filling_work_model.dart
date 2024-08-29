class MudFillingWorkModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic totalDumpers;
  dynamic mudFillingCompStatus;


  MudFillingWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.totalDumpers,
    this.mudFillingCompStatus,

  });

  factory MudFillingWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MudFillingWorkModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        totalDumpers: json['totalDumpers'],
        mudFillingCompStatus:json['mudFillingCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'totalDumpers':totalDumpers,
      'mudFillingCompStatus':mudFillingCompStatus,


    };
  }
}
