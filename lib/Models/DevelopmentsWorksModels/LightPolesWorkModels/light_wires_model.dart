class LightWiresModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic totalLength;
  dynamic date;

  LightWiresModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.totalLength,
    this.date

  });

  factory LightWiresModel.fromMap(Map<dynamic,dynamic>json)
  {
    return LightWiresModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      totalLength: json['totalLength'],
        date:  json['date']
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'totalLength':totalLength,
      'date':date

    };
  }
}
