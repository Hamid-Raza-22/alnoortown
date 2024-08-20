class MosqueExavationWorkModel{
  int? id;
  dynamic blockNo;
  String? completionStatus;
  final String? timestamp; //added by arfa



  MosqueExavationWorkModel({
    this.id,
    this.blockNo,
    this.completionStatus,
    this.timestamp, //added by arfa


  });

  factory MosqueExavationWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return MosqueExavationWorkModel(
      id: json['id'],
      blockNo: json['blockNo'],
      completionStatus: json['completionStatus'],



    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'completionStatus':completionStatus,


    };
  }
}
