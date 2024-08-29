class MosqueExcavationWorkModel{
  int? id;
  dynamic blockNo;
  dynamic completionStatus;
  dynamic date;



  MosqueExcavationWorkModel({
    this.id,
    this.blockNo,
    this.completionStatus,
    this.date


  });

  factory MosqueExcavationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MosqueExcavationWorkModel(
      id: json['id'],
      blockNo: json['blockNo'],
      completionStatus: json['completionStatus'],
        date:  json['date']


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'completionStatus':completionStatus,
      'date':date

    };
  }
}
