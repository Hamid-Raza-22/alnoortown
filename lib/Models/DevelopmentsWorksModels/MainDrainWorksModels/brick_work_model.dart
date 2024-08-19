class BrickWorkModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic completedLength;
  dynamic date;




  BrickWorkModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.completedLength,
    this.date



  });

  factory BrickWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return BrickWorkModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      completedLength: json['completedLength'],
        date:  json['date']


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'completedLength':completedLength,
      'date':date

    };
  }
}
