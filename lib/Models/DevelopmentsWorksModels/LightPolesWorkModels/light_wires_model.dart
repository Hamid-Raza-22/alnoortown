class LightWiresModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? totalLength;


  LightWiresModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.totalLength,

  });

  factory LightWiresModel.fromMap(Map<dynamic,dynamic>json)
  {
    return LightWiresModel(
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
