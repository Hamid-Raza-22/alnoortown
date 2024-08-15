class PlasterWorkModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? completedLength;




  PlasterWorkModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.completedLength,



  });

  factory PlasterWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PlasterWorkModel(
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
