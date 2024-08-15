class ShutteringWorkModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? completedLength;




  ShutteringWorkModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.completedLength,



  });

  factory ShutteringWorkModel.fromMap(Map<dynamic,dynamic>json)
  {
    return ShutteringWorkModel(
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
      'ShutteringWorkModel':ShutteringWorkModel,

    };
  }
}
