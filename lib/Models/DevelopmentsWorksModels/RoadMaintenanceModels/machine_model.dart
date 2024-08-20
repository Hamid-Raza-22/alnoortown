class MachineModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic machine;
  dynamic timeIn;
  dynamic timeOut;
  dynamic date;


  MachineModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.machine,
    this.timeIn,
    this.timeOut,
    this.date
  });

  factory MachineModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MachineModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      machine: json['machine'],
      timeIn: json['timeIn'],
      timeOut: json['timeOut'],
      date:  json['date']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'machine':machine,
      'timeIn':timeIn,
      'timeOut':timeOut,
      'date':date
    };
  }
}
