class IronWorksModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? completedLength;



  IronWorksModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.completedLength,


  });

  factory IronWorksModel.fromMap(Map<dynamic,dynamic>json)
  {
    return IronWorksModel(
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
      'completedLength':completedLength,

    };
  }
}
