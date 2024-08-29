class PolesExcavationModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic lengthTotal;
  dynamic date;

  PolesExcavationModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.lengthTotal,
    this.date

  });

  factory PolesExcavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PolesExcavationModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      lengthTotal: json['lengthTotal'],
        date:  json['date']

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'lengthTotal':lengthTotal,
      'date':date

    };
  }
}
