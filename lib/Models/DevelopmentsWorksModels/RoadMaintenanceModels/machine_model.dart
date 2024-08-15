class MachineModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? machine;
  String? timeIn;
  String? timeOut;

  MachineModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.machine,
    this.timeIn,
    this.timeOut
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
    };
  }
}
