class PolesModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? totalLength;


  PolesModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.totalLength,

  });

  factory PolesModel.fromMap(Map<dynamic,dynamic>json)
  {
    return PolesModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      totalLength: json['totalLength'],

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'totalLength':totalLength,

    };
  }
}
