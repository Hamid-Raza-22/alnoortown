
class FilingModel{
  int? id;
  String? blockNo;
  String? streetNo;
  String? status;


  FilingModel({
    this.id,
    this.blockNo,
    this.streetNo,
    this.status,

  });

  factory FilingModel.fromMap(Map<dynamic,dynamic>json)
  {
    return FilingModel(
      id: json['id'],
      blockNo: json['blockNo'],
      streetNo: json['streetNo'],
      status: json['status'],

    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'blockNo':blockNo,
      'streetNo':streetNo,
      'status':status,

    };
  }
}
