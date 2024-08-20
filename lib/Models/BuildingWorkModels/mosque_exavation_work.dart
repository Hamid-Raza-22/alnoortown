class MosqueExavationWorkModel{
  int? id;
  dynamic blockNo;
  dynamic completionStatus;
  dynamic date;



  MosqueExavationWorkModel({
    this.id,
    this.blockNo,
    this.completionStatus,
    this.date


  });

  factory MosqueExavationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MosqueExavationWorkModel(
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
