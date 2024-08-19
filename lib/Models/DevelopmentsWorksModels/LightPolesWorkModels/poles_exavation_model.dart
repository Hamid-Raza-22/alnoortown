class PolesExavationModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic lengthTotal;
  dynamic date;

  PolesExavationModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.lengthTotal,
    this.date

  });

  factory PolesExavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PolesExavationModel(
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
