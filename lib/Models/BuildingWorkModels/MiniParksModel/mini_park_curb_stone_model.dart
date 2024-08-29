class MiniParkCurbStoneModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic mpCurbStoneCompStatus;


  MiniParkCurbStoneModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mpCurbStoneCompStatus,

  });

  factory MiniParkCurbStoneModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MiniParkCurbStoneModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        mpCurbStoneCompStatus:json['mpCurbStoneCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'mpCurbStoneCompStatus':mpCurbStoneCompStatus,


    };
  }
}
