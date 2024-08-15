class ShiftingWorkModel{
  int? id;
  String? fromBlock;
  String? toBlock;
  String? numOfShift;




  ShiftingWorkModel({
    this.id,
    this.fromBlock,
    this.toBlock,
    this.numOfShift,



  });

  factory ShiftingWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ShiftingWorkModel(
      id: json['id'],
      fromBlock: json['fromBlock'],
      toBlock: json['toBlock'],
      numOfShift: json['numOfShift'],


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'fromBlock':fromBlock,
      'toBlock':toBlock,
      'numOfShift':numOfShift,

    };
  }
}
