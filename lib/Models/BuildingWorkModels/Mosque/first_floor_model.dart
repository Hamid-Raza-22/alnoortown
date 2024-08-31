class FirstFloorModel{
  int? id;
  dynamic blockNo;
  dynamic brickWork;
  dynamic mudFiling;
  dynamic plasterWork;
  dynamic date;
  dynamic time;
  FirstFloorModel({
    this.id,
    this.blockNo,
    this.brickWork,
    this.mudFiling,
    this.plasterWork,
    this.date,
    this.time
  });

  factory FirstFloorModel.fromMap(Map<dynamic,dynamic>json)
  {
    return FirstFloorModel(
        id: json['id'],
        blockNo: json['blockNo'],
        brickWork: json['brickWork'],
        mudFiling: json['mudFiling'],
        plasterWork: json['plasterWork'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'brickWork':brickWork,
      'mudFiling':mudFiling,
      'plasterWork':plasterWork,
      'date':date,
      'time':time,
    };
  }
}
