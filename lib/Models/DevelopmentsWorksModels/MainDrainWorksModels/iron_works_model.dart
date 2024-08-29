class IronWorksModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic completedLength;
  dynamic date;

  IronWorksModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.completedLength,
    this.date
  });

  factory IronWorksModel.fromMap(Map<dynamic,dynamic>json)
  {
    return IronWorksModel(
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
      'completedLength':completedLength,
      'date':date

    };
  }
}
