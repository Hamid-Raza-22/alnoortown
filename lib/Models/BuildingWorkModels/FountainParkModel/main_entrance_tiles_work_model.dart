class MainEntranceTilesWorkModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic mainEntranceTilesWorkCompStatus;


  MainEntranceTilesWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.mainEntranceTilesWorkCompStatus,

  });

  factory MainEntranceTilesWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainEntranceTilesWorkModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        mainEntranceTilesWorkCompStatus:json['mainEntranceTilesWorkCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'mainEntranceTilesWorkCompStatus':mainEntranceTilesWorkCompStatus,


    };
  }
}
