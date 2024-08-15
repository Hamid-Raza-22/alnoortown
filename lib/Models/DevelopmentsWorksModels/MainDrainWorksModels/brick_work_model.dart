class BrickWorkModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? completedLength;




  BrickWorkModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.completedLength,



  });

  factory BrickWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return BrickWorkModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      completedLength: json['completedLength'],


    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'completedLength':completedLength,

    };
  }
}
