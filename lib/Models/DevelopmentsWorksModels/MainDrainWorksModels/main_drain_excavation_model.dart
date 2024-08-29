class MainDrainExcavationModel{
  int? id;
  dynamic blockNo;
  dynamic streetNo;
  dynamic completedLength;
  dynamic date;

  MainDrainExcavationModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.completedLength,
    this.date
  });

  factory MainDrainExcavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MainDrainExcavationModel(
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
