class TankerModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? tankerNo;


  TankerModel ({
    this.id,
    this.blockNo,
    this.streetNo,
    this.tankerNo,

  });

  factory TankerModel.fromMap(Map<dynamic,dynamic>json)
  {
    return TankerModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      tankerNo: json['tankerNo'],

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      ' tankerNo':tankerNo,

    };
  }
}
