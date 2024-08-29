
class ExcavationModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic length;
  dynamic date;

  ExcavationModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.length,
    this.date

  });

  factory ExcavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ExcavationModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      length: json['length'],
        date:  json['date']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'length':length,
      'date':date

    };
  }
}
