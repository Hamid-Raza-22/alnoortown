class ShiftingWorkModel{
  int? id;
  dynamic fromBlock;
  dynamic toBlock;
  dynamic numOfShift;
  dynamic date;

  ShiftingWorkModel({
    this.id,
    this.fromBlock,
    this.toBlock,
    this.numOfShift,
    this.date
  });

  factory ShiftingWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ShiftingWorkModel(
      id: json['id'],
      fromBlock: json['fromBlock'],
      toBlock: json['toBlock'],
      numOfShift: json['numOfShift'],
        date:  json['date']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'fromBlock':fromBlock,
      'toBlock':toBlock,
      'numOfShift':numOfShift,
      'date':date
    };
  }
}
