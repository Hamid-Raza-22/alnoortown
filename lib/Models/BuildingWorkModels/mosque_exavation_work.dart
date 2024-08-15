class MosqueExavationWorkModel{
  int? id;
  String? blockNo;
  String? completionStatus;




  MosqueExavationWorkModel({
    this.id,
    this.blockNo,
    this.completionStatus,



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
