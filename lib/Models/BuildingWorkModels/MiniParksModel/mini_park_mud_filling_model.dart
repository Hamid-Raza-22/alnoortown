class MiniParkMudFillingModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic totalDumpers;
  dynamic mpMudFillingCompStatus;


  MiniParkMudFillingModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.totalDumpers,
    this.mpMudFillingCompStatus,

  });

  factory MiniParkMudFillingModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MiniParkMudFillingModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        totalDumpers: json['totalDumpers'],
        mpMudFillingCompStatus:json['mpMudFillingCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'totalDumpers':totalDumpers,
      'mpMudFillingCompStatus':mpMudFillingCompStatus,


    };
  }
}
