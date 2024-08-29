class ElectricityWorkModel{
  int? id;
  dynamic blockNo;
  dynamic electricityWorkStatus;
  dynamic date;



  ElectricityWorkModel({
    this.id,
    this.blockNo,
    this.electricityWorkStatus,
    this.date


  });

  factory ElectricityWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ElectricityWorkModel(
        id: json['id'],
        blockNo: json['blockNo'],
        electricityWorkStatus: json['electricityWorkStatus'],
        date:  json['date']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'electricityWorkStatus':electricityWorkStatus,
      'date':date

    };
  }
}
