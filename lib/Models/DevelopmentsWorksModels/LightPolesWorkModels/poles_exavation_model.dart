class PolesExavationModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? lengthTotal;


  PolesExavationModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.lengthTotal,

  });

  factory PolesExavationModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PolesExavationModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      lengthTotal: json['lengthTotal'],

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'lengthTotal':lengthTotal,

    };
  }
}
