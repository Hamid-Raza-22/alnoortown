class PlantationWorkModel{
  int? id;
  dynamic startDate;
  dynamic expectedCompDate;
  dynamic plantationCompStatus;


  PlantationWorkModel({
    this.id,
    this.startDate,
    this.expectedCompDate,
    this.plantationCompStatus,

  });

  factory PlantationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PlantationWorkModel(
        id: json['id'],
        startDate: json['startDate'],
        expectedCompDate: json['expectedCompDate'],
        plantationCompStatus:json['plantationCompStatus']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'startDate':startDate,
      'expectedCompDate':expectedCompDate,
      'plantationCompStatus':plantationCompStatus,


    };
  }
}
