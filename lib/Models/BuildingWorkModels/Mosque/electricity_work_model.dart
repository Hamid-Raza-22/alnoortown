class ElectricityWorkModel{
  int? id;
  dynamic blockNo;
  dynamic electricityWorkStatus;
  dynamic date;
  dynamic time;
  ElectricityWorkModel({
    this.id,
    this.blockNo,
    this.electricityWorkStatus,
    this.date,
    this.time
  });

  factory ElectricityWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ElectricityWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        electricityWorkStatus: json['electricityWorkStatus'],
        date:  json['date'],
        time:  json['time']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'electricityWorkStatus':electricityWorkStatus,
      'date':date,
      'time':time,
    };
  }
}
